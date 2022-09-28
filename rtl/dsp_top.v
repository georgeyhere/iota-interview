// dsp_top.v 
// Foreign Object Detection DSP Unit
//
// Dependencies:
//     - fifo_async.v
//     - dsp_adc_receiver.v 
//     - dsp_rectifier.v 
//     - dsp_averager.v 
//     - dsp_detection.v 
// 
// Receives source-synchronous data from an LTC2229 ADC, rectifies the signal,
// averages it over the period that the ADC is enabled, and compares the average 
// value to a variable threshold value. When the average output is equal to or 
// greater than a variable unsigned value, the DSP unit flags a signal declaring 
// a foreign object has been detected. 
//
// Throughput: 1:1 
// Pipeline Latency: 
//     -> dsp_rectifier: 1 cycle
//     -> dsp_averager:  1 cycle 
//     -> dsp_detection: 1 cycle 
//     ---------> Total: 3 cycles
//
// Since the design only needs to run at 100MHz there is plenty of room to reduce 
// latency if required. 
//
module dsp_top
    (
    // System
    input  wire        CLK_100MHz, //! 100MHz clock input 
    input  wire        SRESET_n,   //! sync active-low reset

    // ADC Interface
    input  wire        ADC_CLK,    //! 32 MHz ADC external sample clock 
    input  wire        ADC_OE_n,   //! ADC active-low enable bit
    input  wire        ADC_OF,     //! ADC overflow flag 
    input  wire [11:0] ADC_DATA,   //! 12-bit ADC data

    // Detection Interface
    input  wire [11:0] DETECTION_THRESHOLD, //! detection threshold
    output wire        DETECTED    //! active-high object detected oneshot flag
    );

//
    wire [13:0] receiver_data_o;   //! ADC data packet word output from receiver
    wire        receiver_valid_o;  //! Indicates receiver_data_o is valid 

    wire [13:0] rectifier_data_o;  //! ADC data packet word from rectifier
    wire        rectifier_valid_o; //! Indicates rectifier_data_o is valid 

    wire [11:0] averager_data_o;   //! Averaged ADC data 
    wire        averager_valid_o;  //! Indicates averager_data_o is valid 

//
    dsp_adc_receiver receiver_i 
    (
        .i_clk    (CLK_100MHz),
        .i_rstn   (SRESET_n),

        .ADC_CLK  (ADC_CLK),
        .ADC_OE_n (ADC_OE_n),
        .ADC_OF   (ADC_OF),
        .ADC_DATA (ADC_DATA),

        .i_ready  (1'b1),
        .o_data   (receiver_data_o),
        .o_valid  (receiver_valid_o)
    );

    dsp_rectifier rectifier_i 
    (
        .i_clk   (CLK_100MHz),
        .i_rstn  (SRESET_n),

        .i_data  (receiver_data_o),
        .i_valid (receiver_valid_o),

        .o_data  (rectifier_data_o),
        .o_valid (rectifier_valid_o)
    );

    dsp_averager averager_i 
    (
        .i_clk   (CLK_100MHz),
        .i_rstn  (SRESET_n),
        
        .i_data  (rectifier_data_o),
        .i_valid (rectifier_valid_o),

        .o_data  (averager_data_o),
        .o_valid (averager_valid_o)
    );

    dsp_detection detection_i 
    (
        .i_clk   (CLK_100MHz),
        .i_rstn  (SRESET_n),
        
        .i_data  (averager_data_o),
        .i_valid (averager_valid_o),

        .i_threshold (DETECTION_THRESHOLD),
        .o_detected  (DETECTED)
    );

endmodule 