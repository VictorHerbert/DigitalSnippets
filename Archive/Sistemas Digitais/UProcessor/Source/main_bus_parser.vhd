library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity main_bus_parser is
	generic(n : integer);
	port(
		bus1 : in std_logic_vector(n-1 downto 0);
		bus2 : in std_logic_vector(n-1 downto 0);
		bus3 : in std_logic_vector(n-1 downto 0);
		bus4 : in std_logic_vector(n-1 downto 0);
		bus5 : in std_logic_vector(n-1 downto 0);
		bus6 : in std_logic_vector(n-1 downto 0);
		bus7 : in std_logic_vector(n-1 downto 0);
		bus8 : in std_logic_vector(n-1 downto 0);
		bus9 : in std_logic_vector(n-1 downto 0);
		bus10 : in std_logic_vector(n-1 downto 0);
		bus11 : in std_logic_vector(n-1 downto 0);
		bus12 : in std_logic_vector(n-1 downto 0);
		bus_out : out std_logic_vector(n-1 downto 0)
	);
end main_bus_parser;

architecture arch of main_bus_parser is
begin

bus_out <= bus1 or bus2 or bus3 or bus4 or bus5 or bus6 or bus7 or bus8 or bus9 or bus10 or bus11 or bus12;

end arch;