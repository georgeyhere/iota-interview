# /tb

__dsp_adc_receiver_tb.sv__
- Testbench for dsp_adc_receiver
- Includes ADC model that generates random data 
- User-configurable overflow flag generation
- User-configurable timing parameters
- Self-checking funtionality

__dsp_rectifier_tb.sv__
- Testbench for dsp_rectifier
- Includes SV Task to generate user-defined number of random ADC values
- User-configurable number of tests to run
- Test statistics report - number of positive and negative values rectified in a run
- Self-checking functionality

__dsp_averager_tb.sv__
- Testbench for dsp_averager
- Includes SV Task to generate ADC packet words with the following user-defined parameters:
    -  Overall packet length
    -  Overflow flag enable
    -  Overflow flag at which index of the packet
    -  Random overflow flag generation 
- Self-checking functionality

__dsp_top_tb.sv__
- System-level Testbench for dsp_top 
- Includes ADC model that generates random data
- **No self-checking capability, verification through waveform inspection only.**
  - Each submodule was verified independently, writing a self-checking testbench here is possible but would be very time consuming. Potential use case for UVM.
  