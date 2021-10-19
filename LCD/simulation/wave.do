radix binary 

add wave -divider "Input"

add wave clk
add wave clk_slow
add wave reset

add wave write
add wave -literal address
add wave -radix unsigned write_data


add wave -divider

add wave lcd_16x2_avalon/write
add wave lcd_16x2_avalon/data_available
add wave lcd_16x2_avalon/write_done
add wave -radix unsigned lcd_16x2_avalon/data
add wave -radix unsigned lcd_16x2_avalon/counter

add wave -divider "Output"

add wave E
add wave RS
add wave -radix unsigned DATA

run -all
wave zoom range 0ps 10000ns

