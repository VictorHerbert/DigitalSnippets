library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Displays_7seg_decoder is
	port (
		number	: in std_logic_vector(7 downto 0);
		hasSigBit: in std_logic;
		HEX0 		: out std_logic_vector(6 downto 0);
		HEX1	 	: out std_logic_vector(6 downto 0);
		HEX2 		: out std_logic_vector(6 downto 0);
		HEX3 		: out std_logic_vector(6 downto 0)
	);
end Displays_7seg_decoder;

architecture arch of Displays_7seg_decoder is

	component bcd_7seg_decoder is
		port (
			BCD	: integer range 0 to 15;
			HEX 	: out std_logic_vector(6 downto 0)
		);
	end component;
	
	signal num	: integer range 0 to 255;
	signal uni, dez, cent : integer range 0 to 10;
	
	signal modNumber : std_logic_vector(7 downto 0);
begin

gen: for i in 0 to 5 generate
  HEX3(i) <= ('1');
end generate;
HEX3(6) <= not hasSigBit;

modNumber <=
	number when hasSigBit = '0' else
	not (number-"00000001");
	
num <= to_integer(unsigned(modNumber));

uni <= num mod 10;
dez <= (num/10) mod 10;
cent <= (num/100) mod 10;


hex_display0 : bcd_7seg_decoder
	port map(
		uni,
		HEX0
	);
	
hex_display1 : bcd_7seg_decoder
	port map(
		dez,
		HEX1
	);
	
hex_display2 : bcd_7seg_decoder
	port map(
		cent,
		HEX2
	);
	
	
end arch;

	


