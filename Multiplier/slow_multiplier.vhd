library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity slow_multiplier is
	generic(n : integer := 8);
	port(
		a,b 		: in std_logic_vector(n-1 downto 0);
		s			: out std_logic_vector(n-1 downto 0);
		clk 		: in std_logic;
		reset		: in std_logic;
		ready		: out std_logic
	);
end slow_multiplier;

architecture arch of slow_multiplier is
	signal acum : std_logic_vector(2*n-1 downto 0);
	signal w : std_logic_vector(2*n-1 downto 0);
	signal x : std_logic_vector(n-1 downto 0);
begin

s <= acum(n-1 downto 0);

process(clk)
	variable counter : integer range 0 to n := 0;
begin
	if(reset = '1') then
		w(n-1 downto 0) <= a;
		w(2*n-1 downto n) <= (others=> '0');
		x <= b;
		acum <= (others=> '0');
		
		counter := 0;
		ready <= '0';
		
	elsif(falling_edge(clk)) then
		w(2*n-1 downto 1) <= w(2*n-2 downto 0);
		w(0) <= '0';
		
		x(n-2 downto 0) <= x(n-1 downto 1);
		
		if(counter <= n-1) then
			counter := counter + 1;
			if(x(0) = '1') then
				acum <= acum+w;
			end if;
		else	
			ready <= '1';
		end if;
	end if;
	
end process;

end arch;