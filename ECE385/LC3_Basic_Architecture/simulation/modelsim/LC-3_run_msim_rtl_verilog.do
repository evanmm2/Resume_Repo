transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/tristate.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/Flipflop.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/MUX.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/data-path.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/slc3.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/lab6_toplevel.sv}

vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/LC-3 {C:/Users/BEN/Desktop/Quartus/LC-3/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 2000 ns
