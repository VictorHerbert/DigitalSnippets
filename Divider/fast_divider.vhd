library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fast_divider is
	generic(n : integer);
	port(
		a,b 	: in std_logic_vector(n-1 downto 0);
		c	 	: out std_logic_vector(n-1 downto 0);
		rmod	: out std_logic_vector(n-1 downto 0);
		clk 	: in std_logic;
		reset	: in std_logic;
		ready : out std_logic
	);
end fast_divider;

architecture arch of fast_divider is
	signal w 		: std_logic_vector(2*n-1 downto 0);	
	signal x 		: std_logic_vector(2*n-1 downto 0);
	signal s 		: std_logic_vector(n-1 downto 0);
begin

c <= s;

process(clk)
	variable counter : integer;
begin	
	
	rmod <= w(n-1 downto 0);

	if(reset = '1') then
		w(n-1 downto 0) <= a;
		w(2*n-1 downto n) <= (others => '0');
		
		x(n-1 downto 0) <= (others => '0');
		x(2*n-1 downto n) <= b;
		
		
		ready <= '0';
		s <= (others => '0');
		rmod <= (others => '0');
		
		counter := 0;
		
	elsif(falling_edge(clk)) then
		if(counter <= n) then
			counter := counter+1;
		
			x(2*n-1) <= '0';
			x(2*n-2 downto 0) <= x(2*n-1 downto 1);
				
			s(n-1 downto 1) <= s(n-2 downto 0);
			
			if(w >= x) then
				w <= w-x;
				s(0) <= '1';
			else
				s(0) <= '0';
			end if;			
		else
			ready <= '1';
		end if;
		
	end if;
	
end process;

end arch;