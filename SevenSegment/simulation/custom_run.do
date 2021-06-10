transcript on

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}

vlib rtl_work
vmap work rtl_work


vlog -sv -work work +incdir+../src {../DoubleDabble/double_dabble.sv}
vlog -sv -work work +incdir+../src {../DoubleDabble/testbench.sv}


vsim -t 1ps -L rtl_work -L work -voptargs="+acc"  testbench

view structure
view signals

do wave.do