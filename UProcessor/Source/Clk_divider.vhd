library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
 
entity clk_divider is
	generic(
		multiplier 	: integer
	);
	port(
		clk_in 		: in std_logic;
		clk_out		: out std_logic
	);
end clk_divider;
 
architecture arch of clk_divider is
	signal clk_div: std_logic;
begin
 
	process(clk_in)
		variable count: integer:= 0;                                               
	begin                                                      
		if(rising_edge(clk_in)) then
			count:= count+1;
			if(count = multiplier) then
				clk_div <= not clk_div;
				count:= 1;
			end if;
		end if;
	end process;
 
clk_out <= clk_div;
 
end arch;