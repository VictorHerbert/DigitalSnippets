library ieee;
use ieee.std_logic_1164.all;

entity FFT is
	port(
		t		: in std_logic;
		clk	: in std_logic;
		q,qn	: buffer std_logic
	);
end FFT;

architecture arch of FFT is
	signal q_temp : std_logic;
begin

qn <= not q;

process(clk,t)
begin
	if(falling_edge(clk) and t = '1') then
		q <= not q;
		
	end if;
end process;

end arch;