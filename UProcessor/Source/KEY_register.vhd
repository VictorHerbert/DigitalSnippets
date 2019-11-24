library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity KEY_register is	
	port(
		data_bus_in	: in std_logic_vector(7 downto 0);
		data_bus_out: out std_logic_vector(7 downto 0);
		data_in		: in std_logic;
		data_out		: in std_logic;
		has_data		: out std_logic;
		clk			: in std_logic;
		reset			: in std_logic
	);
end KEY_register;

architecture arch of KEY_register is
	signal data : std_logic_vector(7 downto 0) := (others => '0');
	signal incomming_data : std_logic_vector(7 downto 0) := (others => '0');
	signal conv : std_logic_vector(7 downto 0) := (others => '0');
	signal mult,mult1 : std_logic_vector(15 downto 0) := (others => '0');
	signal isNumber : std_logic := '0';
	
begin


data_bus_out <=
	data when data_out = '1' else
	(others => '0');

	incomming_data <=
		x"01" when data_bus_in = x"16" else
		x"02" when data_bus_in = x"1E" else
		x"03" when data_bus_in = x"26" else
		x"04" when data_bus_in = x"25" else
		x"05" when data_bus_in = x"2E" else
		x"06" when data_bus_in = x"36" else
		x"07" when data_bus_in = x"3D" else
		x"08" when data_bus_in = x"3E" else
		x"09" when data_bus_in = x"46" else
		x"00" when data_bus_in = x"45" else
		x"FF";
		
	mult <= (data*x"0A"+incomming_data);	
	
	isNumber <= 
		'1' when data_bus_in = x"16" else
		'1' when data_bus_in = x"1E" else
		'1' when data_bus_in = x"26" else
		'1' when data_bus_in = x"25" else
		'1' when data_bus_in = x"2E" else
		'1' when data_bus_in = x"36" else
		'1' when data_bus_in = x"3D" else
		'1' when data_bus_in = x"3E" else
		'1' when data_bus_in = x"46" else
		'1' when data_bus_in = x"45" else
		'0';
		
--	has_data <= 
--		'1' when clk = '0' and data_bus_in = x"5A" else
--		'0';

process(clk)
begin
	if(reset = '1') then
		data <= (others => '0');
	elsif(falling_edge(clk)) then
		if(data_in = '1' and data_bus_in = x"66") then
			data <= (others => '0');
			has_data <= '0';
		elsif(data_in = '1' and data_bus_in = x"5A") then
			has_data <= '1';
		elsif(data_in = '1' and isNumber = '1') then
			has_data <= '0';
			data <= (mult(7 downto 0));
		else
			has_data <= '0';
		end if;
	end if;
end process;

end arch;