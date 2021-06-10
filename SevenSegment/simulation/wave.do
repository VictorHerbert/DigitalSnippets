radix binary
add wave clk
add wave write

add wave -divider

add wave -radix unsigned data
add wave -radix unsigned {digits[3:0]}

add wave -divider

add wave -color "Goldenrod" double_dabble_inst/shift_reg
add wave -color "Goldenrod" double_dabble_inst/add_reg

add wave -divider

add wave -color "Magenta" double_dabble_inst/counter
add wave -color "Magenta" double_dabble_inst/counter_finish

run -all
wave zoom range 0ps 150ps