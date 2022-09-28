// dsp_adc_receiver.v
//
// This module captures data from the ADC and writes it to an asynchronous FIFO. 
// The ADC data is source-synchronous and so the capture process is also 
// synchronous to the external ADC_CLK. 
//
// In addition to capturing the ADC data, it is necessary to identify the start of
// an ADC frame such that processing elements can resynchronize if a packet is 
// interrupted for whatever reason. 
//
// The module is also responsible for identifying overflows in an ADC packet. If at
// any point in a packet the ADC_OF flag is asserted, the packet should be considered
// invalid.
//
// The data format written to the FIFO is as such:
// [13]:   SoF flag
// [12]:   Overflow flag 
// [11:0]: 12-bit ADC data
//
// 
module dsp_adc_receiver
    (
    input  wire        i_clk,    //! 100MHz system clock
    input  wire        i_rstn,   //! Synchronous active-low reset

    // ADC Interface
    input  wire        ADC_CLK,  //! ADC clock
    input  wire        ADC_OE_n, //! ADC active-low valid 
    input  wire        ADC_OF,   //! ADC overflow  
    input  wire [11:0] ADC_DATA, //! ADC data; 12-bit 2's complement

    // Data Out Interface 
    input  wire        i_ready,  //! Indicates slave is ready to receive data
    output reg  [13:0] o_data,   //! Output data
    output reg         o_valid   //! Indicates o_data is valid
    );

// ADC frame SOF detection
    reg  q_adc_oe_n; //! FF used for ADC_oe_n SoF detection
    wire adc_sof;    //! Indicates ADC_oe_n falling edge; SoF flag

// Async FIFO interface signals
    wire fifo_wr;           //! Internal async FIFO write enable
    wire fifo_rd;           //! Internal async FIFO read enable
    wire fifo_rempty;       //! Internal async FIFO empty flag
    wire [13:0] fifo_rdata; //!


// Data Capture (source-synchronous)
    assign fifo_wr = !ADC_OE_n;
    always@(posedge ADC_CLK) begin : SoF_Detect
        if(!i_rstn) q_adc_oe_n <= 1;
        else        q_adc_oe_n <= ADC_OE_n;
    end 
    assign adc_sof = !ADC_OE_n & q_adc_oe_n;

// Data Out 
    assign fifo_rd = i_ready && !fifo_rempty;
    always@(posedge i_clk) begin : Output_Interface
        if(!i_rstn) begin 
            o_valid <= 0;
            o_data  <= 0;
        end 
        else begin
            o_valid <= fifo_rd;
            o_data  <= fifo_rdata; 
        end       
    end 

// FIFO Instantiation
    fifo_async #(
        .DATA_WIDTH (14),
        .PTR_WIDTH  (3)
    ) receiver_buffer_i (
        .i_wclk   (ADC_CLK),
        .i_wrstn  (i_rstn),
        .i_wr     (fifo_wr),
        .i_wdata  ({adc_sof, ADC_OF, ADC_DATA}), 
        .o_wfull  (), // unused
        
        .i_rclk   (i_clk),
        .i_rrstn  (i_rstn),
        .i_rd     (fifo_rd),
        .o_rdata  (fifo_rdata),
        .o_rempty (fifo_rempty)
    );


endmodule 
