transcript on

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}

vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {../cordic.vhd}
vcom -2008 -work work {../testbench.vhd}

vsim -t 1ns -L rtl_work -L work -voptargs="+acc"  testbench

view structure
view signals

do wave.do