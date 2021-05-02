library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_7seg_decoder is
	port (
		--BCD	: integer range 0 to 15;
		BCD	: in std_logic_vector(3 downto 0);
		HEX 	: out std_logic_vector(6 downto 0)
	);
end bcd_7seg_decoder;

architecture arch of bcd_7seg_decoder is
	signal B : std_logic_vector(3 downto 0);
	signal H : std_logic_vector(6 downto 0);
	
begin

--B <= std_logic_vector(to_unsigned(BCD,4));
b <= BCD;

H <=	
	"1111110" when B = "0000" else
	"0110000" when B = "0001" else
	"1101101" when B = "0010" else 
	"1111001" when B = "0011" else
	"0110011" when B = "0100" else
	"1011011" when B = "0101" else 
	"1011111" when B = "0110" else 
	"1110000" when B = "0111" else
	"1111111" when B = "1000" else
	"1111011" when B = "1001" else
	"1110111" when B = "1010" else 
	"0011111" when B = "1011" else
	"1001110" when B = "1100" else
	"0111101" when B = "1101" else 	
	"1001111" when B = "1110" else 
	"1000111" when B = "1111" else 	
	"0000000";		
	
gen: for i in 0 to 6 generate
  HEX(i) <= not H(6-i);
end generate;

end arch;
