# Entity: dsp_top 

- **File**: dsp_top.v
## Diagram

![Diagram](dsp_top.svg "Diagram")
## Ports

| Port name           | Direction | Type        | Description                              |
| ------------------- | --------- | ----------- | ---------------------------------------- |
| CLK_100MHz          | input     | wire        | 100MHz clock input                       |
| SRESET_n            | input     | wire        | sync active-low reset                    |
| ADC_CLK             | input     | wire        | 32 MHz ADC external sample clock         |
| ADC_OE_n            | input     | wire        | ADC active-low enable bit                |
| ADC_OF              | input     | wire        | ADC overflow flag                        |
| ADC_DATA            | input     | wire [11:0] | 12-bit ADC data                          |
| DETECTION_THRESHOLD | input     | wire [11:0] | detection threshold                      |
| DETECTED            | output    | wire        | active-high object detected oneshot flag |
## Signals

| Name              | Type        | Description                               |
| ----------------- | ----------- | ----------------------------------------- |
| receiver_data_o   | wire [13:0] | ADC data packet word output from receiver |
| receiver_valid_o  | wire        | Indicates receiver_data_o is valid        |
| rectifier_data_o  | wire [13:0] | ADC data packet word from rectifier       |
| rectifier_valid_o | wire        | Indicates rectifier_data_o is valid       |
| averager_data_o   | wire [11:0] | Averaged ADC data                         |
| averager_valid_o  | wire        | Indicates averager_data_o is valid        |
## Instantiations

- receiver_i: dsp_adc_receiver
- rectifier_i: dsp_rectifier
- averager_i: dsp_averager
- detection_i: dsp_detection
