radix binary 

add wave ps2_clk
add wave -literal ps2_data
add wave -radix hex data

add wave -divider

add wave ps2_keyboard_i0/data_reg
add wave -radix decimal ps2_keyboard_i0/counter
add wave ps2_keyboard_i0/parity_check


run -all
wave zoom range 0ps 3ms

