transcript on

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}

vlib rtl_work
vmap work rtl_work


vlog -sv -work work +incdir+../src {../ripple_adder.sv}
vlog -sv -work work +incdir+../src {../full_adder.sv}
vlog -sv -work work +incdir+../src {../testbench.sv}


vsim -t 1ns -L rtl_work -L work -voptargs="+acc"  testbench

view structure
view signals

do wave.do