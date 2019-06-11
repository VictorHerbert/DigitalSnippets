library IEEE;
use IEEE.std_logic_1164.all;

entity ShiftRegister is
	generic(n : integer := 8);
	port(
		parallel_in	: in std_logic_vector(n-1 downto 0);
		parallel_out: out std_logic_vector(n-1 downto 0);
		out_enable	: in std_logic;
		serial_in	: in std_logic;
		serial_out	: out std_logic;
		reset 		: in std_logic;
		clk 			: in std_logic;
		ready			: out std_logic
	);
end ShiftRegister;

architecture arch of ShiftRegister is
	signal word : std_logic_vector(n-1 downto 0);
begin

serial_out <= word(n-1);
parallel_out <= word;
			
	process(clk)
		variable counter : integer range 0 to n := 0;
	begin
		if(reset = '1') then
			word <= parallel_in;
			counter := 0;
			ready <= '0';
		
		elsif(falling_edge(clk)) then
			word(n-1 downto 1) <= word(n-2 downto 0);
			word(0) <= serial_in;
			
			if(counter = n-1) then
				counter := 0;
				ready <= '1';
			else
				counter := counter+1;
			end if;
			
		end if;
	end process;
end;
