`timescale 1ns/1ps

module dsp_rectifier_tb();

// TEST PARAMETERS
    parameter T_CLK = 10;
    parameter TEST_COUNT = 420;

// TEST VARS
    logic i_clk;
    logic i_rstn;
    logic [13:0] i_data;
    logic        i_valid;
    logic [13:0] o_data;
    logic        o_valid;

// DUT INSTANTIATION
    dsp_rectifier DUT (
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
        i_rstn  = 1;
        i_data  = 0;
        i_valid = 0;
    end 

//
    typedef struct {
        int posCount;
        int negCount;
    } TB_STATS;
    TB_STATS statsInst;

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
    task doTest;
    input int n;
    logic [11:0] val;
    begin 
        for(int i=0; i<n; i++) begin 
            val = $random();
            if(val[11]) begin 
                statsInst.negCount++;
                t_expected_queue.push_front(~val + 1'b1);
            end 
            else begin 
                statsInst.posCount++;
                t_expected_queue.push_front(val);
            end 

            @(posedge i_clk) begin 
                i_data  <= val;
                i_valid <= (i != n-1);
            end 
        end 
    end 
    endtask

// CHECKER
    logic [11:0] t_expected;
    always@(posedge i_clk) begin 
        if(o_valid) begin 
            t_expected = t_expected_queue.pop_back();
            if(o_data[11:0] != t_expected) begin 
                $display("%0t: FAIL: DATA MISMATCH! Expected: %d  | Actual: %d",
                         $time, t_expected[11:0], o_data[11:0]);
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

        doTest(TEST_COUNT);

        $display("\nAll Tests Passed!");
        $display("Negative numbers tested: %d", statsInst.negCount);
        $display("Positive numbers tested: %d", statsInst.posCount);
        $finish();

    end 

endmodule 
