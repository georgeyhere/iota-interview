// dsp_averager.v
//
// This module continuously averages rectified ADC sample data from the start of 
// a data packet of n words. The average is valid as long as there is no ADC
// overflow detected. 
//
// If a word from a packet is indicated to be overflow, then all subsequent
// data is ignored and the valid flag will not be asserted until the next ADC
// activation period.
//
// The data received from the ADC is in the following format:
// [13]:   SoF flag
// [12]:   Overflow flag 
// [11:0]: 12-bit ADC data
//
//
module dsp_averager
    (
    input  wire        i_clk,   //! 100MHz system clock
    input  wire        i_rstn,  //! Sync active-low reset

    // Input Interface
    input  wire [13:0] i_data,  //! ADC packet data word; see header for format
    input  wire        i_valid, //! Indicates i_data is valid

    // Output Interface
    output reg  [11:0] o_data,  //! 12-bit averaged data
    output reg         o_valid  //! Indicates o_data is valid
    );

// FSM
    localparam ST_IDLE = 0;
    localparam ST_AVG  = 1;
    reg STATE; //! State Flop

// 
    wire overflow; //! ADC packet data word overflow flag
    wire sof;      //! ADC packet data word SoF flag
    assign sof      = i_data[13];
    assign overflow = i_data[12];

    wire [12:0] avg; //! o_data combinatorial logic
    assign avg = (o_data + i_data[11:0]) >> 1;

//
    always@(posedge i_clk) begin : FSM 
        if(!i_rstn) begin 
            STATE   <= ST_IDLE;
            o_valid <= 0;
            o_data  <= 0;
        end 
        else begin 
            o_valid <= 0;

            case(STATE)
                ST_IDLE: begin 
                    if(i_valid && sof && !overflow) begin 
                        STATE   <= ST_AVG;
                        o_data  <= i_data[11:0];
                        o_valid <= 1;
                    end 
                end 

                ST_AVG: begin 
                    if(i_valid) begin 
                        // overflow detected
                        if(overflow) begin 
                            STATE  <= ST_IDLE;
                            o_data <= 0;
                        end 

                        // reset average if SoF detected
                        else if(sof) begin 
                            o_data  <= i_data[11:0];
                            o_valid <= 1;
                        end 

                        // standard average operation
                        else begin
                            o_data  <= avg[11:0];
                            o_valid <= 1;
                        end
                    end 
                end 
            endcase
        end 
    end 

endmodule
