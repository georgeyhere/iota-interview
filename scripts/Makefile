SHELL := /bin/bash 

compile: 
	vlog ../rtl/fifo_async.v
	vlog ../rtl/dsp_adc_receiver.v 
	vlog -sv ../tb/dsp_adc_receiver_tb.sv

	vlog ../rtl/dsp_rectifier.v
	vlog -sv ../tb/dsp_rectifier_tb.sv

	vlog ../rtl/dsp_averager.v
	vlog -sv ../tb/dsp_averager_tb.sv

	vlog ../rtl/dsp_detection.v 

	vlog ../rtl/dsp_top.v
	vlog -sv ../tb/dsp_top_tb.sv 

fifo:
	vlog ../rtl/fifo_async.v

receiver:  
	vlog ../rtl/fifo_async.v
	vlog ../rtl/dsp_adc_receiver.v 
	vlog -sv ../tb/dsp_adc_receiver_tb.sv
	vsim -c dsp_adc_receiver_tb -do "run -all"

rectifier:
	vlog ../rtl/dsp_rectifier.v
	vlog -sv ../tb/dsp_rectifier_tb.sv
	vsim -c dsp_rectifier_tb -do "run -all"

averager:
	vlog ../rtl/dsp_averager.v 
	vlog -sv ../tb/dsp_averager_tb.sv 
	vsim -c dsp_averager_tb -do "run -all"

top: compile
	vsim -c dsp_top_tb -do "run -all"

clean: 
	rm -rf wlftWU6uHZ
	rm -rf transcript
	rm -rf vsim.wlf
	rm -rf work