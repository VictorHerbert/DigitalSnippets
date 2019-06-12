library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Seven_Seg_Decoder_Register is
	generic(
		mode : std_logic := '0'
	);
	port (
		BCD				: in std_logic_vector(3 downto 0);
		lamp_test 		: in std_logic;
		latch_enable	: in std_logic;
		blanking 		: in std_logic;
		HEX 				: out std_logic_vector(6 downto 0)
	);
end Seven_Seg_Decoder_Register;

architecture arch of Seven_Seg_Decoder_Register is
	signal latches : std_logic_vector(3 downto 0);
	signal decoder : std_logic_vector(6 downto 0);
	signal driver : std_logic_vector(6 downto 0);
begin

latches <=
	BCD when latch_enable = '0'
	else latches;
	
driver <=
	"1111111" when lamp_test ='0'
	else decoder;
				
mode_loop : for i in 0 to 6 generate
	HEX(i) <= driver(i) xor mode;
end generate; 

decoder <=
	"0000000" when blanking ='0' else
	"1111110" when latches = "0000" else
	"0110000" when latches = "0001" else
	"1101101" when latches = "0010" else 
	"1111001" when latches = "0011" else
	"0110011" when latches = "0100" else
	"1011011" when latches = "0101" else 
	"1011111" when latches = "0110" else 
	"1110000" when latches = "0111" else
	"1111111" when latches = "1000" else
	"0000000";

end arch;



		