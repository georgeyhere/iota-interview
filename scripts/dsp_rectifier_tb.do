onerror {resume}
quietly virtual signal -install /dsp_rectifier_tb/DUT { /dsp_rectifier_tb/DUT/i_data[11:0]} data
quietly WaveActivateNextPane {} 0
add wave -noupdate /dsp_rectifier_tb/DUT/i_clk
add wave -noupdate /dsp_rectifier_tb/DUT/i_rstn
add wave -noupdate -expand -group {Input Interface} -radix decimal /dsp_rectifier_tb/DUT/data
add wave -noupdate -expand -group {Input Interface} /dsp_rectifier_tb/DUT/i_valid
add wave -noupdate -expand -group {Output Interface} -radix decimal /dsp_rectifier_tb/DUT/o_data
add wave -noupdate -expand -group {Output Interface} /dsp_rectifier_tb/DUT/o_valid
add wave -noupdate -radix decimal -childformat {{{/dsp_rectifier_tb/t_expected[11]} -radix decimal} {{/dsp_rectifier_tb/t_expected[10]} -radix decimal} {{/dsp_rectifier_tb/t_expected[9]} -radix decimal} {{/dsp_rectifier_tb/t_expected[8]} -radix decimal} {{/dsp_rectifier_tb/t_expected[7]} -radix decimal} {{/dsp_rectifier_tb/t_expected[6]} -radix decimal} {{/dsp_rectifier_tb/t_expected[5]} -radix decimal} {{/dsp_rectifier_tb/t_expected[4]} -radix decimal} {{/dsp_rectifier_tb/t_expected[3]} -radix decimal} {{/dsp_rectifier_tb/t_expected[2]} -radix decimal} {{/dsp_rectifier_tb/t_expected[1]} -radix decimal} {{/dsp_rectifier_tb/t_expected[0]} -radix decimal}} -subitemconfig {{/dsp_rectifier_tb/t_expected[11]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[10]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[9]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[8]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[7]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[6]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[5]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[4]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[3]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[2]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[1]} {-height 17 -radix decimal} {/dsp_rectifier_tb/t_expected[0]} {-height 17 -radix decimal}} /dsp_rectifier_tb/t_expected
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38343 ps} 0}
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
WaveRestoreZoom {0 ps} {131238 ps}
