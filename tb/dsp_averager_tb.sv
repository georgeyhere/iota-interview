`timescale 1ns/1ps

module dsp_averager_tb();

// TEST PARAMETERS
    parameter T_CLK = 10;

// TEST VARS
    logic i_clk;
    logic i_rstn;

    logic [13:0] i_data;
    logic        i_valid;

    logic [11:0] o_data;
    logic        o_valid; 

// DUT INSTANTIATION
    dsp_averager DUT (
        .i_clk   (i_clk),
        .i_rstn  (i_rstn),
        .i_data  (i_data),
        .i_valid (i_valid),
        .o_data  (o_data),
        .o_valid (o_valid)
    );

// CLOCK GEN + INITIALIZATION
    initial i_clk = 0;
    always#(T_CLK/2) i_clk = !i_clk;

    initial begin 
        $timeformat(-9,0, " ns");
        i_rstn = 0;
        i_data = 0;
        i_valid = 0;
    end 

// SIM TASKS
    task resetDut;
    begin 
        $display("\n%0t: Driving a sync reset to the DUT\n", $time);
        @(posedge i_clk); i_rstn = 0;
        @(posedge i_clk); i_rstn <= 1;
        @(posedge i_clk);
    end 
    endtask

    logic [11:0] t_expected_queue [$];

    task sendPacket;
    input int size;
    input bit overflow;
    input int overflow_idx;
    input bit overflow_rand_en;

    logic [11:0] data [$];
    logic [11:0] temp;
    int accumulator;
    int rand_overflow_idx;

    begin 
        rand_overflow_idx = $urandom_range(0, size-1);
        t_expected_queue.delete();
        data.delete();
        temp = 0;

        for(int i=0; i<size; i++) begin 
            temp = $random;
            data.push_front(temp);

            if(i==0) accumulator += temp;
            else accumulator = (accumulator + temp) / 2;
            
            if(!overflow) begin 
                t_expected_queue.push_front(accumulator);
            end 
            else if(overflow_rand_en) begin 
                if(i<rand_overflow_idx) t_expected_queue.push_front(accumulator);
            end 
            else if(i<overflow_idx) begin 
                t_expected_queue.push_front(accumulator);
            end 
        end 

        for(int i=0; i<size; i++) begin 

            @(posedge i_clk) begin 
                i_valid <= (i<size-1);

                if(overflow == 0) 
                    i_data  <= {(i==0), 1'b0, data.pop_back()};
                else if (overflow_rand_en)
                    i_data  <= {(i==0), (i==rand_overflow_idx), data.pop_back()};
                else 
                    i_data  <= {(i==0), (i==overflow_idx), data.pop_back()};
            end 
        end 

        @(posedge i_clk);
    end 
    endtask 

//
    logic [11:0] t_expected;
    always@(posedge i_clk) begin 
        if(!i_rstn) begin 
            t_expected_queue.delete();
        end 
        else if(o_valid) begin 
            t_expected = t_expected_queue.pop_back();
            
            if(t_expected != o_data) begin 
                $display("%0t: FAIL: DATA MISMATCH! Expected: %d  | Actual: %d",
                         $time, t_expected[11:0], o_data[11:0]);
                #10;
                $stop();
            end 
            else begin 
                $display("%0t: PASS: DATA MATCH!    Expected: %d  | Actual: %d",
                         $time, t_expected[11:0], o_data[11:0]);
            end 
        end 
    end 

// MAIN SIM
    initial begin 
        resetDut();

        sendPacket(.size(33), .overflow(1), .overflow_idx(5), .overflow_rand_en(0));

        sendPacket(.size(33), .overflow(0), .overflow_idx(0), .overflow_rand_en(0));

        $display("\n All Tests Passed!\n");
        $finish();
    end 

endmodule 
