# Entity: dsp_rectifier 

- **File**: dsp_rectifier.v
## Diagram

![Diagram](dsp_rectifier.svg "Diagram")
## Ports

| Port name | Direction | Type        | Description                                    |
| --------- | --------- | ----------- | ---------------------------------------------- |
| i_clk     | input     | wire        | 100MHz system clock                            |
| i_rstn    | input     | wire        | Sync active-low reset                          |
| i_data    | input     | wire [13:0] | ADC packet data word; see header for format    |
| i_valid   | input     | wire        | Indicates i_data is valid                      |
| o_data    | output    | [13:0]      | ADC packet data word containing rectified data |
| o_valid   | output    |             | Indicates o_data is valid                      |
## Processes
- rectify: ( @(posedge i_clk) )
  - **Type:** always
