library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Program_Counter is
	generic(
		n : integer
	);
	port(
		reset_address 	: in std_logic_vector(n-1 downto 0);
		data_bus_in		: in std_logic_vector(n-1 downto 0);
		data_bus_out	: out std_logic_vector(n-1 downto 0);
		data_in			: in std_logic;
		data_out			: in std_logic;
		clk				: in std_logic;
		count_inc		: in std_logic;
		reset				: in std_logic
	);
end Program_Counter;

architecture arch of Program_Counter is
	signal data : std_logic_vector(n-1 downto 0) := reset_address;
begin

data_bus_out <=
	data when data_out = '1' else
	(others => '0');

process(clk, count_inc)
begin
	if(reset = '1') then
		data <=  reset_address;
	elsif(falling_edge(clk) and data_in = '1') then
		data <= data_bus_in;
	elsif(falling_edge(clk) and count_inc = '1') then
		data <= data + 1;
	end if;
end process;
	
end arch;