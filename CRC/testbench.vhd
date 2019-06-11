
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench;

architecture arch of testbench is
	component CRC is 
		generic(
			n	: integer := 10;
			pol_size		: integer := 5;
			crc_pol		: std_logic_vector(4 downto 0) := "10111"
		);
		port(
			serial	: in std_logic;
			word_out	: out std_logic_vector(pol_size-2 downto 0);		
			clk 		: in std_logic;
			reset		: in std_logic;
			ready		: out std_logic
		);
	end component;
	
	signal word_in		:  std_logic_vector(9 downto 0);
	signal serial		:  std_logic := '1';
	signal word_out 	:  std_logic_vector(3 downto 0);		
	signal clk 			:  std_logic;
	signal reset		:  std_logic;
	signal ready		:  std_logic;
begin

word_in <= "101011" & "0000";

test : CRC
		port map(
			serial,
			word_out,
			clk,
			reset,
			ready
		);
			
			
serial <=
	word_in(9),
	word_in(8) after 40 ns,
	word_in(7) after 80 ns,
	word_in(6) after 120 ns,
	word_in(5) after 160 ns,
	word_in(4) after 200 ns,
	word_in(3) after 240 ns,
	word_in(2) after 280 ns,
	word_in(1) after 320 ns,
	word_in(0) after 360 ns;


process
begin
	for i in 0 to 20 loop
		clk <= '1' ;
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
	end loop;
	wait;
end process;


reset <=
	'1',
	'0' after 10 ns;
	

end arch;