radix binary 

add wave clk
add wave -color yellow write_enable
add wave -color purple data_in

add wave -divider

add wave ready
add wave -literal serial_data_out

run -all
wave zoom range 0ns 100ns

