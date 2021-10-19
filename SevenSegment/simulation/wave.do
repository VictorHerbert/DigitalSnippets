radix binary

add wave -divider "Avalon Input"
add wave clk
add wave reset
add wave write
add wave -color "blue" -radix unsigned write_data


add wave -divider "Double Dabble"

add wave segment_avalon_i0/double_dabble_i0/write
add wave -color "Goldenrod" segment_avalon_i0/double_dabble_i0/data

add wave -color "Goldenrod" segment_avalon_i0/double_dabble_i0/data_buffer
add wave -color "Goldenrod" segment_avalon_i0/double_dabble_i0/shift_reg
add wave -radix unsigned -color "Goldenrod" segment_avalon_i0/double_dabble_i0/counter


add wave -divider "Output"

add wave -radix unsigned -color "purple" segment_avalon_i0/numbers
add wave -color "purple" digits
add wave -color "purple" segments

run -all
wave zoom range 0ps 1000ns