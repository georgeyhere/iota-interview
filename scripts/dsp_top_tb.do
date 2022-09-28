onerror {resume}
quietly virtual function -install /dsp_top_tb/DUT/receiver_i -env /dsp_top_tb/DUT/receiver_i { &{/dsp_top_tb/DUT/receiver_i/o_data[11], /dsp_top_tb/DUT/receiver_i/o_data[10], /dsp_top_tb/DUT/receiver_i/o_data[9], /dsp_top_tb/DUT/receiver_i/o_data[8], /dsp_top_tb/DUT/receiver_i/o_data[7], /dsp_top_tb/DUT/receiver_i/o_data[6], /dsp_top_tb/DUT/receiver_i/o_data[5], /dsp_top_tb/DUT/receiver_i/o_data[4], /dsp_top_tb/DUT/receiver_i/o_data[3], /dsp_top_tb/DUT/receiver_i/o_data[2], /dsp_top_tb/DUT/receiver_i/o_data[1], /dsp_top_tb/DUT/receiver_i/o_data[0] }} captured_data
quietly virtual function -install /dsp_top_tb/DUT/rectifier_i -env /dsp_top_tb/DUT/rectifier_i { &{/dsp_top_tb/DUT/rectifier_i/o_data[11], /dsp_top_tb/DUT/rectifier_i/o_data[10], /dsp_top_tb/DUT/rectifier_i/o_data[9], /dsp_top_tb/DUT/rectifier_i/o_data[8], /dsp_top_tb/DUT/rectifier_i/o_data[7], /dsp_top_tb/DUT/rectifier_i/o_data[6], /dsp_top_tb/DUT/rectifier_i/o_data[5], /dsp_top_tb/DUT/rectifier_i/o_data[4], /dsp_top_tb/DUT/rectifier_i/o_data[3], /dsp_top_tb/DUT/rectifier_i/o_data[2], /dsp_top_tb/DUT/rectifier_i/o_data[1], /dsp_top_tb/DUT/rectifier_i/o_data[0] }} Rectified_Data
quietly WaveActivateNextPane {} 0
add wave -noupdate /dsp_top_tb/CLK_100MHz
add wave -noupdate /dsp_top_tb/SRESET_n
add wave -noupdate -expand -group {ADC Interface} /dsp_top_tb/ADC_CLK
add wave -noupdate -expand -group {ADC Interface} /dsp_top_tb/ADC_OE_n
add wave -noupdate -expand -group {ADC Interface} /dsp_top_tb/ADC_OF
add wave -noupdate -expand -group {Receiver Output} -label Received_SoF {/dsp_top_tb/DUT/receiver_i/o_data[13]}
add wave -noupdate -expand -group {Receiver Output} -label Received_Overflow {/dsp_top_tb/DUT/receiver_i/o_data[12]}
add wave -noupdate -expand -group {Receiver Output} -label Received_Data -radix decimal /dsp_top_tb/DUT/receiver_i/captured_data
add wave -noupdate -expand -group {Receiver Output} /dsp_top_tb/DUT/receiver_i/o_valid
add wave -noupdate -expand -group {Rectifier Output} -label Rectifier_SoF {/dsp_top_tb/DUT/rectifier_i/o_data[13]}
add wave -noupdate -expand -group {Rectifier Output} -label Rectifier_Overflow {/dsp_top_tb/DUT/rectifier_i/o_data[12]}
add wave -noupdate -expand -group {Rectifier Output} /dsp_top_tb/DUT/rectifier_i/Rectified_Data
add wave -noupdate -expand -group {Rectifier Output} /dsp_top_tb/DUT/rectifier_i/o_valid
add wave -noupdate -expand -group {Averager Output} /dsp_top_tb/DUT/averager_i/o_data
add wave -noupdate -expand -group {Averager Output} /dsp_top_tb/DUT/averager_i/o_valid
add wave -noupdate -expand -group {Detection Output} /dsp_top_tb/DUT/detection_i/i_threshold
add wave -noupdate -expand -group {Detection Output} /dsp_top_tb/DUT/detection_i/o_detected
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {382 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
