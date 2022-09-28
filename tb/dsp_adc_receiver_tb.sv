`timescale 1ns/1ps

module dsp_adc_receiver_tb(); 

// TEST PARAMETERS
    localparam T_ADC_CLK = 31; // ADC_CLK period in ns 
    localparam T_SYS_CLK = 10; // system clock period in ns 

    parameter  ADC_MS_DURATION = 10000; // adjust for faster sim runtime
    parameter  ADC_US_DURATION = 1000;

    localparam ADC_MS_COUNTER_VAL = ADC_MS_DURATION / T_ADC_CLK; 
    localparam ADC_US_COUNTER_VAL = ADC_US_DURATION / T_ADC_CLK;

// TEST VARS
    logic i_clk;
    logic i_rstn;

    logic        ADC_CLK;
    logic        ADC_OE_n;
    logic        ADC_OF;
    logic [11:0] ADC_DATA;

    logic        i_ready;
    logic [13:0] o_data;
    logic        o_valid;

// DUT INSTANTIATION
    dsp_adc_receiver DUT 
    (
        .i_clk    (i_clk),
        .i_rstn   (i_rstn),

        .ADC_CLK  (ADC_CLK),
        .ADC_OE_n (ADC_OE_n),
        .ADC_OF   (ADC_OF),
        .ADC_DATA (ADC_DATA),

        .i_ready  (i_ready),
        .o_data   (o_data),
        .o_valid  (o_valid)
    );

// CLOCK GEN 
    initial ADC_CLK = 0;
    always#(T_ADC_CLK/2) ADC_CLK = !ADC_CLK;

    initial i_clk = 0;
    always#(T_SYS_CLK/2) i_clk = !i_clk;

// INITIAL VALUES
    initial begin 
        $timeformat(-9,0, " ns");
        i_rstn   = 0;
        ADC_OE_n = 1;
        ADC_OF   = 0;
        ADC_DATA = 0;
        i_ready  = 1;
    end 

/***************** ADC ******************/
// The ADC is enabled for 1us every 1ms. 
    typedef struct {
        int          clk_count;
        logic [11:0] data;
        bit          overflow_en;
        bit          sof;
    } TB_ADC;
    TB_ADC adcInst;

    logic [13:0] t_expected_queue [$];

// Model
    always@(posedge ADC_CLK) begin 
        if(adcInst.clk_count == ADC_MS_COUNTER_VAL-1) begin 
            adcInst.clk_count <= 0;
        end 
        else begin 
            adcInst.clk_count <= adcInst.clk_count + 1;
        end

        adcInst.sof <= (adcInst.clk_count == 0);
        if(adcInst.clk_count < ADC_US_COUNTER_VAL) begin 
            adcInst.data = $random;
            ADC_OE_n <= 0;
            ADC_DATA <= adcInst.data;
            ADC_OF   <= adcInst.overflow_en; 
        end 
        else begin 
            ADC_OE_n <= 1;
        end 
    end 

// Monitor
    always@(posedge ADC_CLK, negedge i_rstn) begin 
        if(!i_rstn) begin 
            t_expected_queue.delete();
        end 
        else if(!ADC_OE_n) begin 
            t_expected_queue.push_front({adcInst.sof,
                                         ADC_OF, 
                                         ADC_DATA});
        end 
    end 

/************** SIM TASKS ****************/
// Reset task
    task resetDut;
    begin 
        $display("\n%0t: Driving a sync reset to the DUT\n", $time);
        @(posedge i_clk); i_rstn = 0;
        @(posedge i_clk); i_rstn <= 1;
        @(posedge i_clk);
    end 
    endtask


/************** CHECKER ******************/
    logic [13:0] expected;
    bit fail = 0;
    always@(posedge i_clk) begin 
        if(o_valid) begin 
            expected = t_expected_queue.pop_back();
            $display("\n");

            // check sof flag
            if(o_data[13] != expected[13]) begin 
                fail = 1;
                $display("%0t: FAIL: SoF FLAG MISMATCH!      Expected: %d   | Actual: %d",
                         $time, expected[13], o_data[13]);
            end 
            else begin 
                $display("%0t: PASS: SoF FLAG MATCH!         Expected: %d   | Actual: %d",
                         $time, expected[13], o_data[13]);
            end 

            // check overflow flag
            if(o_data[12] != expected[12]) begin 
                fail = 1;
                $display("%0t: FAIL: OVERFLOW FLAG MISMATCH! Expected: %d   | Actual: %d",
                         $time, expected[12], o_data[12]);
            end 
            else begin 
                $display("%0t: PASS: OVERFLOW FLAG MATCH!    Expected: %d   | Actual: %d",
                         $time, expected[12], o_data[12]);
            end

            // check data
            if(o_data[11:0] != expected[11:0]) begin 
                fail = 1;
                $display("%0t: FAIL: DATA MISMATCH!          Expected: %h | Actual: %h",
                         $time, expected[11:0], o_data[11:0]);
            end 
            else begin 
                $display("%0t: PASS: DATA MATCH!             Expected: %h | Actual: %h",
                         $time, expected[11:0], o_data[11:0]);
            end

            if(fail) begin 
                #10;
                $stop;
            end 
        end 
    end 

/****************** MAIN SIM *****************/
    initial begin 
        resetDut();
        #100000;

        adcInst.overflow_en = 1;
        #100000;

        adcInst.overflow_en = 0;
        #100000;

        $display("\nAll Tests Passed!\n");
        $finish();
    end 

endmodule
