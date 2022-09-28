# /rtl

## See the file header of each submodule for more specific details.

__fifo_async.v__
- Simple async FIFO
- Created in a prior project

__dsp_adc_receiver.v__
- Captures ADC data into an async FIFO
- ADC packet SoF and Overflow flags packed with each data word
- Ready-Valid output interface
- **Testbench: /tb/dsp_adc_receiver_tb.sv**

__dsp_rectifier.v__
- Rectifies ADC data by returning its RMS value
- Passes ADC packet SoF and Overflow flag values through
- 1:1 Throughput
- 1 cycle latency
- **Testbench: /tb/dsp_rectifier_tb.sv**

__dsp_averager.v__
- Continuously averages ADC sample data 
- Average resets if SoF flag is set 
- Average is invalid if Overflow flag is set
- 1:1 Throughput
- 1 cycle latency
- **Testbench: /tb/dsp_averager_tb.sv**

__dsp_detection.v__
- Compares ADC averaged data with a given threshold
- DETECTED flag set if average value higher than threshold
- 1:1 Throughput
- 1 cycle latency

__dsp_top.v__
- Instantiates all submodule components
- **Testbench: /tb/dsp_top_tb.sv**
