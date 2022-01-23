onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/dut/datapath_mod/execution_state/PC_PLUS_FOUR_EN_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/PC_PLUS_FOUR_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/BR_EN
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/BR_EN_NEXT
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/PC_JUMP
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/CMP1_INPUT
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/CMP2_INPUT
add wave -noupdate /mp4_tb/dut/datapath_mod/execution_state/RS1_FORWARD_SEL
add wave -noupdate /mp4_tb/dut/datapath_mod/execution_state/RS2_FORWARD_SEL
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/RS1_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/RS2_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/memory_io_stage/RD_MEM
add wave -noupdate -childformat {{{/mp4_tb/dut/datapath_mod/regfile_mod/data[0]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[1]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[2]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[3]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[4]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[5]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[6]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[7]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[8]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[9]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[10]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[11]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[12]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[13]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[14]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[15]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[16]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[17]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[18]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[19]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[20]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[21]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[22]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[23]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[24]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[25]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[26]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[27]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[28]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[29]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[30]} -radix hexadecimal} {{/mp4_tb/dut/datapath_mod/regfile_mod/data[31]} -radix hexadecimal}} -expand -subitemconfig {{/mp4_tb/dut/datapath_mod/regfile_mod/data[0]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[1]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[2]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[3]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[4]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[5]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[6]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[7]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[8]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[9]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[10]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[11]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[12]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[13]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[14]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[15]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[16]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[17]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[18]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[19]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[20]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[21]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[22]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[23]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[24]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[25]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[26]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[27]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[28]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[29]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[30]} {-radix hexadecimal} {/mp4_tb/dut/datapath_mod/regfile_mod/data[31]} {-radix hexadecimal}} /mp4_tb/dut/datapath_mod/regfile_mod/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4009160 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 469
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {3958330 ps} {4031210 ps}
