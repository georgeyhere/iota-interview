// dsp_detection.v 
//
// This module performs thresholding on a 12-bit data field. This module could
// easily be implemented using combinatorial logic with minimal resource utilization
// but again, here it is registered for timing performance in a theoretical 
// high-speed system. 
// It has 1:1 throughput and a 1-cycle latency. 
//
//
module dsp_detection  
    (
    input  wire        i_clk,       //! 100MHz system clock 
    input  wire        i_rstn,      //! Sync active-low reset

    // Data In Interface
    input  wire [11:0] i_data,      //! 12-bit averaged ADC value
    input  wire        i_valid,     //! Indicates i_data is valid

    // Detection Interface
    input  wire [11:0] i_threshold, //! 12-bit threshold value
    output reg         o_detected   //! Indicates i_data is greater than threshold
    );

    always@(posedge i_clk) begin : threshold 
        if(!i_rstn) o_detected <= 0;
        else        o_detected <= (i_valid && (i_data > i_threshold));
    end 

endmodule
