transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/Register_unit.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/Reg_4.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/Control.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/ripple_adder.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/Processor.sv}

vlog -sv -work work +incdir+C:/Users/BEN/Desktop/Quartus/8\ Bit\ multiplier {C:/Users/BEN/Desktop/Quartus/8 Bit multiplier/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
