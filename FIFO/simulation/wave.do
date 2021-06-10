radix binary
add wave clk
add wave write
add wave read

add wave -divider
add wave fifo_controller_0/empty
add wave fifo_controller_0/full

add wave -divider
add wave -radix unsigned write_addr
add wave -radix unsigned read_addr

run -all
