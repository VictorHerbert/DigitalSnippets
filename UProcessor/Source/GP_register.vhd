library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity GP_register is
	generic(
		n : integer
	);
	port(
		data_bus_in	: in std_logic_vector(n-1 downto 0);
		data_bus_out: out std_logic_vector(n-1 downto 0);
		data_in		: in std_logic;
		data_out		: in std_logic;
		clk			: in std_logic;
		reset			: in std_logic
	);
end GP_register;

architecture arch of GP_register is
	signal data : std_logic_vector(n-1 downto 0) := (others => '0');
begin


data_bus_out <=
	data when data_out = '1' else
	(others => '0');

	
--data <=
--	data_bus_in when data_in = '1' else
--	(others => '0') when reset = '1' else
--	data;



process(clk)
begin
	if(reset = '1') then
		data <= (others => '0');
	elsif(falling_edge(clk)) then
		if(data_in = '1') then
			data <= data_bus_in;
		end if;
	end if;
end process;

end arch;