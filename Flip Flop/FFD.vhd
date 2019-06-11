library ieee;
use ieee.std_logic_1164.all;

entity FFD is
	port(
		d		: in std_logic;
		clk	: in std_logic;
		q,qn	: buffer std_logic
	);
end FFD;

architecture arch of FFD is
begin

qn <= not q;

process(clk)
begin
	if(falling_edge(clk)) then
		q <= d;
	end if;
end process;

end arch;