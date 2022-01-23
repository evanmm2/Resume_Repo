onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp4_tb/dut/arbiter_mod/RDATA_DCACHE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/arbiter_mod/ADDRESS_PMEM
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/RS1_FORWARD_SEL
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/RS2_FORWARD_SEL
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/ALU1_INPUT
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/ALU2_INPUT
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/REGFILE_MUX_OUT
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/REGFILE_IN_MEM_WB
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/ARITH_OUT_MEM
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/RS1_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/RS2_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/PC_PLUS_FOUR_EXE
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/execution_state/REGFILE_MUX_SEL_EXE
add wave -noupdate -radix binary /mp4_tb/dut/datapath_mod/instruction_decode/RS1_FORWARD_ID
add wave -noupdate -radix binary /mp4_tb/dut/datapath_mod/instruction_decode/RS2_FORWARD_ID
add wave -noupdate -radix hexadecimal /mp4_tb/dut/datapath_mod/instruction_decode/REGFILE_IN_MEM_WB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2964750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 480
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
WaveRestoreZoom {2950580 ps} {2992960 ps}
