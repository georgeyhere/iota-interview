onerror {resume}
quietly virtual signal -install /dsp_averager_tb/DUT { /dsp_averager_tb/DUT/i_data[11:0]} data
quietly WaveActivateNextPane {} 0
add wave -noupdate /dsp_averager_tb/DUT/i_clk
add wave -noupdate /dsp_averager_tb/DUT/i_rstn
add wave -noupdate -expand -group {Input Interface} -radix hexadecimal -childformat {{{/dsp_averager_tb/DUT/i_data[13]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[12]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[11]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[10]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[9]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[8]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[7]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[6]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[5]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[4]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[3]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[2]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[1]} -radix hexadecimal} {{/dsp_averager_tb/DUT/i_data[0]} -radix hexadecimal}} -subitemconfig {{/dsp_averager_tb/DUT/i_data[13]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[12]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[11]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[10]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[9]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[8]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[7]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[6]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[5]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[4]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[3]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[2]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[1]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/i_data[0]} {-height 17 -radix hexadecimal}} /dsp_averager_tb/DUT/i_data
add wave -noupdate -expand -group {Input Interface} -radix unsigned -childformat {{{/dsp_averager_tb/DUT/data[11]} -radix unsigned} {{/dsp_averager_tb/DUT/data[10]} -radix unsigned} {{/dsp_averager_tb/DUT/data[9]} -radix unsigned} {{/dsp_averager_tb/DUT/data[8]} -radix unsigned} {{/dsp_averager_tb/DUT/data[7]} -radix unsigned} {{/dsp_averager_tb/DUT/data[6]} -radix unsigned} {{/dsp_averager_tb/DUT/data[5]} -radix unsigned} {{/dsp_averager_tb/DUT/data[4]} -radix unsigned} {{/dsp_averager_tb/DUT/data[3]} -radix unsigned} {{/dsp_averager_tb/DUT/data[2]} -radix unsigned} {{/dsp_averager_tb/DUT/data[1]} -radix unsigned} {{/dsp_averager_tb/DUT/data[0]} -radix unsigned}} -subitemconfig {{/dsp_averager_tb/DUT/i_data[11]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[10]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[9]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[8]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[7]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[6]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[5]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[4]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[3]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[2]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[1]} {-radix unsigned} {/dsp_averager_tb/DUT/i_data[0]} {-radix unsigned}} /dsp_averager_tb/DUT/data
add wave -noupdate -expand -group {Input Interface} /dsp_averager_tb/DUT/i_valid
add wave -noupdate -expand -group {Input Interface} /dsp_averager_tb/DUT/overflow
add wave -noupdate -expand -group {Input Interface} /dsp_averager_tb/DUT/sof
add wave -noupdate -expand -group {Output Interface} -radix unsigned -childformat {{{/dsp_averager_tb/DUT/o_data[11]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[10]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[9]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[8]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[7]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[6]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[5]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[4]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[3]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[2]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[1]} -radix hexadecimal} {{/dsp_averager_tb/DUT/o_data[0]} -radix hexadecimal}} -subitemconfig {{/dsp_averager_tb/DUT/o_data[11]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[10]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[9]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[8]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[7]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[6]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[5]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[4]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[3]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[2]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[1]} {-height 17 -radix hexadecimal} {/dsp_averager_tb/DUT/o_data[0]} {-height 17 -radix hexadecimal}} /dsp_averager_tb/DUT/o_data
add wave -noupdate -expand -group {Output Interface} /dsp_averager_tb/DUT/o_valid
add wave -noupdate /dsp_averager_tb/DUT/STATE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {395000 ps} 0}
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
WaveRestoreZoom {238426 ps} {413768 ps}
