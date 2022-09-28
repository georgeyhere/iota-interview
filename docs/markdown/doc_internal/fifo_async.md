# Entity: fifo_async 

- **File**: fifo_async.v
## Diagram

![Diagram](fifo_async.svg "Diagram")
## Generics

| Generic name | Type | Value | Description |
| ------------ | ---- | ----- | ----------- |
| DATA_WIDTH   |      | 2     |             |
| PTR_WIDTH    |      | 4     |             |
## Ports

| Port name | Direction | Type                  | Description |
| --------- | --------- | --------------------- | ----------- |
| i_wclk    | input     | wire                  |             |
| i_wrstn   | input     | wire                  |             |
| i_wr      | input     | wire                  |             |
| i_wdata   | input     | wire [DATA_WIDTH-1:0] |             |
| o_wfull   | output    |                       |             |
| i_rclk    | input     | wire                  |             |
| i_rrstn   | input     | wire                  |             |
| i_rd      | input     | wire                  |             |
| o_rdata   | output    | wire [DATA_WIDTH-1:0] |             |
| o_rempty  | output    |                       |             |
## Signals

| Name       | Type                  | Description |
| ---------- | --------------------- | ----------- |
| mem        | reg  [DATA_WIDTH-1:0] |             |
| rq1_wptr   | reg  [PTR_WIDTH  :0]  |             |
| rq2_wptr   | reg  [PTR_WIDTH  :0]  |             |
| raddr      | wire [PTR_WIDTH-1:0]  |             |
| rbin       | reg  [PTR_WIDTH  :0]  |             |
| rbinnext   | wire [PTR_WIDTH  :0]  |             |
| rptr       | reg  [PTR_WIDTH  :0]  |             |
| rgraynext  | wire [PTR_WIDTH  :0]  |             |
| rempty_val | wire                  |             |
| wq1_rptr   | reg  [PTR_WIDTH  :0]  |             |
| wq2_rptr   | reg  [PTR_WIDTH  :0]  |             |
| waddr      | wire [PTR_WIDTH-1:0]  |             |
| wbin       | reg  [PTR_WIDTH  :0]  |             |
| wbinnext   | wire [PTR_WIDTH  :0]  |             |
| wptr       | reg  [PTR_WIDTH  :0]  |             |
| wgraynext  | wire [PTR_WIDTH  :0]  |             |
| wfull_val  | wire                  |             |
## Processes
- unnamed: ( @(posedge i_wclk) )
  - **Type:** always
- unnamed: ( @(posedge i_rclk or negedge i_rrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_rclk or negedge i_rrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_rclk or negedge i_rrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_rclk or negedge i_rrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_wclk or negedge i_wrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_wclk or negedge i_wrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_wclk or negedge i_wrstn) )
  - **Type:** always
- unnamed: ( @(posedge i_wclk or negedge i_wrstn) )
  - **Type:** always
