library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity slow_divider is
	generic(n : integer);
	port(
		a,b 	: in std_logic_vector(n-1 downto 0);
		c	 	: out std_logic_vector(n-1 downto 0);
		rmod	: out std_logic_vector(n-1 downto 0);
		clk 	: in std_logic;
		reset	: in std_logic;
		ready : out std_logic
	);
end slow_divider;

architecture arch of slow_divider is
	signal w 		: std_logic_vector(n-1 downto 0);	
	signal x 		: std_logic_vector(n-1 downto 0);
	signal acc 		: std_logic_vector(n-1 downto 0);
begin

	process(reset,clk)
	begin
		if(x = "0") then
			ready <= '1';
			c <= (others => '0');
			rmod <=(others => '0');
		end if;
		
		if(w < x) then
			ready <= '1';
			c <= acc;
			rmod <= w;
		end if;
		
		if(reset = '1') then
			w <= a;
			x <= b;
			ready <= '0';
			acc <= (others => '0');
			c <= (others => '0');
			rmod <= (others => '0');
			
		elsif(falling_edge(clk)) then
			if(w >= x) then
				w <= w-x;
				acc <= acc+1;
			end if;
		end if;	
	end process;

end arch;