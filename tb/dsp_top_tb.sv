`timescale 1ns/1ps

module dsp_top_tb();

// TEST PARAMETERS
    localparam T_ADC_CLK = 31; // ADC_CLK period in ns 
    localparam T_SYS_CLK = 10; // system clock period in ns 

    parameter  ADC_MS_DURATION = 10000; // adjust for faster sim runtime
    parameter  ADC_US_DURATION = 1000;

    localparam ADC_MS_COUNTER_VAL = ADC_MS_DURATION / T_ADC_CLK; 
    localparam ADC_US_COUNTER_VAL = ADC_US_DURATION / T_ADC_CLK;

// TEST VARS
    logic CLK_100MHz;
    logic SRESET_n;
    
    logic        ADC_CLK;
    logic        ADC_OE_n;
    logic        ADC_OF;
    logic [11:0] ADC_DATA;

    logic [11:0] DETECTION_THRESHOLD;
    logic        DETECTED; 

// DUT INSTANTIATION
    dsp_top DUT (
        .CLK_100MHz (CLK_100MHz),
        .SRESET_n   (SRESET_n),
        
        .ADC_CLK    (ADC_CLK),
        .ADC_OE_n   (ADC_OE_n),
        .ADC_OF     (ADC_OF),
        .ADC_DATA   (ADC_DATA),

        .DETECTION_THRESHOLD (DETECTION_THRESHOLD),
        .DETECTED            (DETECTED)
    );

// CLOCK GEN 
    initial ADC_CLK = 0;
    always#(T_ADC_CLK/2) ADC_CLK = !ADC_CLK;

    initial CLK_100MHz = 0;
    always#(T_SYS_CLK/2) CLK_100MHz = !CLK_100MHz;

// INITIAL VALUES
    initial begin 
        $timeformat(-9,0, " ns");
        SRESET_n   = 0;
        ADC_OE_n = 1;
        ADC_OF   = 0;
        ADC_DATA = 0;
        DETECTION_THRESHOLD = $random();
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

/************** SIM TASKS ****************/
// Reset task
    task resetDut;
    begin 
        $display("\n%0t: Driving a sync reset to the DUT\n", $time);
        @(posedge CLK_100MHz); SRESET_n = 0;
        @(posedge CLK_100MHz); SRESET_n <= 1;
        @(posedge CLK_100MHz);
    end 
    endtask

/****************** MAIN SIM *****************/
    initial begin 
        resetDut();
        #100000;

        $display("\nAll Tests Passed!\n");
        $finish();
    end 


endmodule
