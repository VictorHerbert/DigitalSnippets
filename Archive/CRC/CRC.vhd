library IEEE;
use IEEE.std_logic_1164.all;

entity CRC is 
	generic(
		n	: integer := 8;
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
end CRC;

architecture arch of CRC is
	signal crc_in, crc_out : std_logic_vector(pol_size-2 downto 0);-- := (others => '0');

begin

	word_out <= crc_out;
	
	
crcxor0_maker : if crc_pol(0) = '1' generate
	crc_in(0) <= crc_out(pol_size-2) xor serial;
end generate;

crc0_maker : if crc_pol(0) = '0' generate
	crc_in(0) <= serial;
end generate;

xors_maker : for i in 1 to pol_size-2 generate
	crcxor_i_maker : if crc_pol(i) = '1' generate
		crc_in(i) <= crc_out(pol_size-2) xor crc_out(i-1);
	end generate;
	crci_maker : if crc_pol(i) = '0' generate
		crc_in(i) <= crc_out(i-1);
	end generate;
end generate;
	

	process(clk,reset)
		variable counter : integer := 0;
	begin
		if(reset = '1') then
			crc_out <= (others => '0');
			ready <= '0';
		elsif(falling_edge(clk)) then
			if(counter <= n-1) then
				crc_out <= crc_in;
				
				counter := counter + 1;
			else
				ready <= '1';
			end if;
		end if;
	end process;
	
end arch;
