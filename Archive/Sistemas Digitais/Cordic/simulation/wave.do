radix define fx -fixed -fraction 8 -precision 2 -base decimal -signed

add wave clk
add wave reset

add wave -radix fx x
add wave -radix fx y
add wave -radix fx z

add wave -radix fx -label "cos" xo
add wave -radix fx -label "sin" yo

run -all
wave zoom range 0ns 20000ns