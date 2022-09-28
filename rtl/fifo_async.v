// fifo_async.v
//
// This module is an indepedent clocks FIFO.
//
/*
- multi-bit synchronization
    - use an n-bit Gray-code pointer to synchronize read and write pointers
- flags
    - registered for better performance
    - pessimistic
        - flags are removed late
        - two cycle delay due to double FFs
        - note that flags are still set 'accurately'
    - empty flag (read domain)
        - removed with synchronized write pointer
    - full flag  (write domain)
        - removed with synchronized read pointer
*/
module fifo_async 
    #(parameter DATA_WIDTH = 2,
      parameter PTR_WIDTH  = 4)
     
    (
    input  wire                  i_wclk,
    input  wire                  i_wrstn,
    input  wire                  i_wr,
    input  wire [DATA_WIDTH-1:0] i_wdata,
    output reg                   o_wfull,

    input  wire                  i_rclk,
    input  wire                  i_rrstn,
    input  wire                  i_rd,
    output wire [DATA_WIDTH-1:0] o_rdata,
    output reg                   o_rempty
    );

    reg  [DATA_WIDTH-1:0] mem [0:((1<<PTR_WIDTH)-1)];
 
    reg  [PTR_WIDTH  :0] rq1_wptr;
    reg  [PTR_WIDTH  :0] rq2_wptr;

    wire [PTR_WIDTH-1:0] raddr;

    reg  [PTR_WIDTH  :0] rbin; 
    wire [PTR_WIDTH  :0] rbinnext;

    reg  [PTR_WIDTH  :0] rptr;
    wire [PTR_WIDTH  :0] rgraynext; 

    wire rempty_val;

    reg  [PTR_WIDTH  :0] wq1_rptr;
    reg  [PTR_WIDTH  :0] wq2_rptr;

    wire [PTR_WIDTH-1:0] waddr;

    reg  [PTR_WIDTH  :0] wbin;
    wire [PTR_WIDTH  :0] wbinnext;

    reg  [PTR_WIDTH  :0] wptr;
    wire [PTR_WIDTH  :0] wgraynext;

    wire wfull_val;

//
// FIFO MEMORY
// synthesized with ram primitives
    assign o_rdata = mem[raddr];
    always@(posedge i_wclk) begin
        if((i_wr) && (!o_wfull)) mem[waddr] <= i_wdata;
    end

//
// synchronize write pointer to read clock domain
//
    initial {rq1_wptr, rq2_wptr} = 0;
    always@(posedge i_rclk or negedge i_rrstn) begin
        if(!i_rrstn) {rq2_wptr, rq1_wptr} <= 0;
        else         {rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
    end

//
// read pointer and empty generation logic
//
    // MEMORY READ ADDRESS POINTER (binary)
    assign raddr = rbin[PTR_WIDTH-1:0];

    // BINARY COUNTER FOR MEMORY ADDRESSING
    initial rbin = 0;
    always@(posedge i_rclk or negedge i_rrstn) begin
        if(!i_rrstn) rbin <= 0;
        else         rbin <= rbinnext;
    end
    assign rbinnext  = rbin + { {(PTR_WIDTH){1'b0}}, ((i_rd)&&(!o_rempty)) };


     // GRAY-CODE READ POINTER
    initial rptr = 0;
    always@(posedge i_rclk or negedge i_rrstn) begin
        if(!i_rrstn) rptr <= 0;
        else         rptr <= rgraynext;
    end
    assign rgraynext = (rbinnext >> 1) ^ rbinnext;

    // EMPTY FLAG LOGIC
    initial o_rempty = 1;
    always@(posedge i_rclk or negedge i_rrstn) begin 
        if(!i_rrstn) o_rempty <= 1;
        else         o_rempty <= rempty_val; 
    end
    assign rempty_val = (rgraynext == rq2_wptr);


//
// synchronize read pointer to write clock domain
//
    initial {wq1_rptr, wq2_rptr} = 0;
    always@(posedge i_wclk or negedge i_wrstn) begin
        if(!i_wrstn) {wq2_rptr, wq1_rptr} <= 0;
        else         {wq2_rptr, wq1_rptr} <= {wq1_rptr, rptr};
    end

//
// write pointer and full generation logic
//
    // MEMORY WRITE ADDRESS POINTER (binary)
    assign waddr = wbin[PTR_WIDTH-1:0];

    // BINARY COUNTER FOR MEMORY ADDRESSING
    initial wbin = 0;
    always@(posedge i_wclk or negedge i_wrstn) begin
        if(!i_wrstn) wbin <= 0;
        else         wbin <= wbinnext;
    end
    assign wbinnext = wbin + { {(PTR_WIDTH){1'b0}}, ((i_wr) && (!o_wfull)) };

    // GRAY-CODE WRITE POINTER
    initial wptr = 0;
    always@(posedge i_wclk or negedge i_wrstn) begin
        if(!i_wrstn) wptr <= 0;
        else         wptr <= wgraynext;
    end
    assign wgraynext = (wbinnext >> 1) ^ wbinnext; // 100

    // FULL FLAG LOGIC
    initial o_wfull = 0;
    always@(posedge i_wclk or negedge i_wrstn) begin
        if(!i_wrstn) o_wfull <= 0;
        else         o_wfull <= wfull_val;
    end
    assign wfull_val = (wgraynext == {~wq2_rptr[PTR_WIDTH:PTR_WIDTH-1], 
                                       wq2_rptr[PTR_WIDTH-2:0]});



endmodule