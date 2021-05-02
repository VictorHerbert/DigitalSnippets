library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity testbench is
end entity;

architecture arch of testbench is
	component Uprocessor is
		generic(
		n : integer := 8
	);
	port (
		HEX0 		: out std_logic_vector(6 downto 0);
		HEX1 		: out std_logic_vector(6 downto 0);
		HEX2 		: out std_logic_vector(6 downto 0);
		HEX3 		: out std_logic_vector(6 downto 0);
		
		LEDR	 	: out std_logic_vector(9 downto 0);
		LEDG	 	: out std_logic_vector(7 downto 0);
		SW		 	: in std_logic_vector(9 downto 0);
		KEY	 	: in std_logic_vector(3 downto 0);
		CLOCK_50 : in std_logic;
		
		FL_ADDR	: out std_logic_vector(21 downto 0);
		FL_DQ		: in std_logic_vector(7 downto 0);
		FL_OE_N	: out std_logic;
		FL_RST_N	: out std_logic;
		FL_WE_N	: out std_logic;
		
		PS2_CLK 		: in std_logic;
		PS2_DAT		: in std_logic
	);
	end component;
	
	signal HEX0 	:  std_logic_vector(6 downto 0);
	signal HEX1 	:  std_logic_vector(6 downto 0);
	signal HEX2 	:  std_logic_vector(6 downto 0);
	signal HEX3 	:  std_logic_vector(6 downto 0);

	signal LEDR	 	: std_logic_vector(9 downto 0);
	signal LEDG	 	: std_logic_vector(7 downto 0);
	signal SW		: std_logic_vector(9 downto 0);
	signal KEY	 	: std_logic_vector(3 downto 0);
	signal CLOCK_50: std_logic;
	
	signal FL_ADDR	: std_logic_vector(21 downto 0);
	signal FL_DQ	: std_logic_vector(7 downto 0);
	signal FL_OE_N	: std_logic;
	signal FL_RST_N: std_logic;
	signal FL_WE_N	: std_logic;
	
	signal PS2_CLK 	: std_logic;
	signal PS2_DAT		: std_logic;

begin

comp : Uprocessor
	port map(
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		
		LEDR,
		LEDG,
		SW,
		KEY,
		CLOCK_50,
		
		FL_ADDR,
		FL_DQ,
		FL_OE_N,
		FL_RST_N,
		FL_WE_N,
		
		PS2_CLK,
		PS2_DAT
	);
	
	SW(9) <= '0';
	SW(8 downto 0) <= (others => '0');
	KEY(3 downto 1) <= (others => '0');
		
process
begin
	for i in 0 to 100 loop
		KEY(0)<= '1';
		wait for 1 sec;
		KEY(0) <= '0';
		wait for 1 sec;
	end loop;
	wait;
end process;

--SW <= (others => '0');
--KEY <= (others => '0');

FL_DQ <=
	x"00" when FL_ADDR = "00" & x"00000" and FL_OE_N = '0' else
	x"0C" when FL_ADDR = "00" & x"00000" and FL_OE_N = '0' else
	x"01" when FL_ADDR = "00" & x"00001" and FL_OE_N = '0' else
	x"28" when FL_ADDR = "00" & x"00001" and FL_OE_N = '0' else
	x"07" when FL_ADDR = "00" & x"00002" and FL_OE_N = '0' else
	x"00" when FL_ADDR = "00" & x"00002" and FL_OE_N = '0' else
	x"0C" when FL_ADDR = "00" & x"00003" and FL_OE_N = '0' else
	x"00" when FL_ADDR = "00" & x"00003" and FL_OE_N = '0' else
	(others => '0');
	

end arch;
