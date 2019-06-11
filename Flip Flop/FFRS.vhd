library ieee;
use ieee.std_logic_1164.all;

entity FFRS is
	generic(
		FFRS_arch : integer := 1
	);
	port(
		s,r	: in std_logic;
		clk	: in std_logic;
		q,qn	: buffer std_logic
	);
end FFRS;

architecture arch of FFRS is
begin

qn <= not q;

ff1 : if FFRS_arch = 1 generate
	q <=
		'0'	when r ='1' else
		s		when clk = '1' else
		q;
end generate;

ff2 : if FFRS_arch = 2 generate
	process(clk)
	begin
		if(r = '1') then
			q <= '0';
		elsif(falling_edge(clk)) then
			q <= s;
		end if;
	end process;
end generate;

end arch;