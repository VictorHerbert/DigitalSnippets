radix binary

add wave -divider "Input"

add wave                                        clk
add wave                                        clk_90
add wave                -color "Orange"         reset
add wave -literal       -color "purple"         data_in

add wave -divider "CDR"

add wave -literal         -color "blue"   {cdr/a[3]}
add wave -literal         -color "blue"   {cdr/b[3]}
add wave -literal         -color "blue"   {cdr/c[3]}
add wave -literal         -color "blue"   {cdr/d[3]}


add wave -literal         -color "Medium Aquamarine"   cdr/ax
add wave -literal         -color "Medium Aquamarine"   cdr/bx
add wave -literal         -color "Medium Aquamarine"   cdr/cx
add wave -literal         -color "Medium Aquamarine"   cdr/dx


add wave -divider "output"

add wave                    -color "yellow"     clk_out
add wave -literal           -color "Orange"     data_out

run -all;
wave zoom range 0ps 5ms