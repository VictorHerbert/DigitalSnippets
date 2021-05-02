library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;


entity RAM is
	port(
		address 			: in std_logic_vector(7 downto 0);
		data_bus_in 	: in std_logic_vector(7 downto 0);
		data_bus_out	: out std_logic_vector(7 downto 0);
		data_in 			: in std_logic;
		data_out 		: in std_logic;
		data_write 		: in std_logic
	);
end RAM;


architecture arch of RAM is

   type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(7 downto 0);
	
	

begin

	ram(to_integer(unsigned(address))) <=
		data_bus_in when data_in = '1';
	
	data_bus_out <=
		ram(to_integer(unsigned(address))) when data_out = '1' else
		(others => '0');

end architecture arch;