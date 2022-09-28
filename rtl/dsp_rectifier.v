// dsp_rectifier.v
//
// This module rectifies ADC packet data by returning its RMS value.
// ADC value is given to be in 12-bit 2s complement form (-2048 to 1024).
//
// This function could be implemented in combinatorial logic as well with minimal
// resource utilization, but here it is registered for better timing performance in
// a theoretical high-speed system. 
// It has 1:1 throughput and a 1-cycle latency.
//
// The data received from the ADC is in the following format:
// [13]:   SoF flag
// [12]:   Overflow flag 
// [11:0]: 12-bit ADC data
//
// Flags are passed through and only data is processed.
//
module dsp_rectifier
    (
    input  wire        i_clk,   //! 100MHz system clock 
    input  wire        i_rstn,  //! Sync active-low reset

    // Input Interface
    input  wire [13:0] i_data,  //! ADC packet data word; see header for format
    input  wire        i_valid, //! Indicates i_data is valid 

    // Output Interface
    output reg  [13:0] o_data,  //! ADC packet data word containing rectified data
    output reg         o_valid  //! Indicates o_data is valid 
    );

    always@(posedge i_clk) begin : rectify 
        if(!i_rstn) begin 
            o_data  <= 0;
            o_valid <= 0;
        end 
        else begin 
            o_valid       <= i_valid;
            o_data[13:12] <= i_data[13:12]; // pass through flags
            o_data[11:0]  <= (!i_data[11]) ? i_data[11:0] : ~i_data[11:0]+1'b1;
        end 
    end 

endmodule
