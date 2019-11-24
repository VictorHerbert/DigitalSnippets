library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Data_register is
	generic(
		n : integer
	);
	port(
		data_bus 	: inout std_logic_vector(n-1 downto 0);
		data_in		: in std_logic;
		data_out		: in std_logic;
		clk			: in std_logic;
		clr			: in std_logic
	);
end Data_register;

architecture arch of Data_register is
	signal data : std_logic_vector(n-1 downto 0);
begin

	process(clk)
	begin                                                      
		if(rising_edge(clk)) then
			if(clr = '1') then
				data <= (others => '0');
			end if;
			if(data_in = '1') then
				data <= data_bus;
			end if;
			if(data_out = '1') then
				data_bus <= data;
			else
				data_bus <= (others => 'Z');
			end if;
		end if;
	end process;

end arch;