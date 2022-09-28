onerror {resume}
quietly virtual function -install /dsp_adc_receiver_tb -env /dsp_adc_receiver_tb { /dsp_adc_receiver_tb/DUT/o_data[11:0]} adc_data
quietly virtual signal -install /dsp_adc_receiver_tb/DUT {/dsp_adc_receiver_tb/DUT/o_data[13]  } sof
quietly WaveActivateNextPane {} 0
add wave -noupdate /dsp_adc_receiver_tb/DUT/i_clk
add wave -noupdate /dsp_adc_receiver_tb/DUT/i_rstn
add wave -noupdate -expand -group {ADC Interface} /dsp_adc_receiver_tb/DUT/ADC_CLK
add wave -noupdate -expand -group {ADC Interface} /dsp_adc_receiver_tb/DUT/ADC_OE_n
add wave -noupdate -expand -group {ADC Interface} /dsp_adc_receiver_tb/DUT/ADC_OF
add wave -noupdate -expand -group {ADC Interface} -radix hexadecimal /dsp_adc_receiver_tb/DUT/ADC_DATA
add wave -noupdate -expand -group {Output Interface} /dsp_adc_receiver_tb/DUT/i_ready
add wave -noupdate -expand -group {Output Interface} -label adc_sof -radix hexadecimal {/dsp_adc_receiver_tb/DUT/o_data[13]}
add wave -noupdate -expand -group {Output Interface} -label adc_overflow -radix hexadecimal {/dsp_adc_receiver_tb/DUT/o_data[12]}
add wave -noupdate -expand -group {Output Interface} -radix hexadecimal /dsp_adc_receiver_tb/DUT/adc_data
add wave -noupdate -expand -group {Output Interface} -radix hexadecimal -childformat {{{/dsp_adc_receiver_tb/DUT/o_data[13]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[12]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[11]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[10]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[9]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[8]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[7]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[6]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[5]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[4]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[3]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[2]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[1]} -radix hexadecimal} {{/dsp_adc_receiver_tb/DUT/o_data[0]} -radix hexadecimal}} -subitemconfig {{/dsp_adc_receiver_tb/DUT/o_data[13]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[12]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[11]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[10]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[9]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[8]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[7]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[6]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[5]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[4]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[3]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[2]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[1]} {-height 17 -radix hexadecimal} {/dsp_adc_receiver_tb/DUT/o_data[0]} {-height 17 -radix hexadecimal}} /dsp_adc_receiver_tb/DUT/o_data
add wave -noupdate -expand -group {Output Interface} /dsp_adc_receiver_tb/DUT/o_valid
add wave -noupdate -expand -group {FIFO Write Interface} /dsp_adc_receiver_tb/DUT/fifo_wr
add wave -noupdate -expand -group {FIFO Write Interface} /dsp_adc_receiver_tb/DUT/receiver_buffer_i/i_wr
add wave -noupdate -expand -group {FIFO Write Interface} -radix hexadecimal /dsp_adc_receiver_tb/DUT/receiver_buffer_i/i_wdata
add wave -noupdate -expand -group {FIFO Write Interface} /dsp_adc_receiver_tb/DUT/receiver_buffer_i/o_wfull
add wave -noupdate -expand -group {FIFO Read Interface} /dsp_adc_receiver_tb/DUT/fifo_rd
add wave -noupdate -expand -group {FIFO Read Interface} /dsp_adc_receiver_tb/DUT/receiver_buffer_i/i_rd
add wave -noupdate -expand -group {FIFO Read Interface} -radix hexadecimal /dsp_adc_receiver_tb/DUT/receiver_buffer_i/o_rdata
add wave -noupdate -expand -group {FIFO Read Interface} /dsp_adc_receiver_tb/DUT/receiver_buffer_i/o_rempty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {72168 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {107740 ps}
