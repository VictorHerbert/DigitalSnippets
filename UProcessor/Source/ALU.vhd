library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ALU is
	generic(
		n : integer
	);
	port(
		a,b 			: in std_logic_vector(n-1 downto 0);
		s 				: out std_logic_vector(n-1 downto 0);
		op_code 		: in std_logic_vector(7 downto 0);
		flags			: out std_logic_vector(7 downto 0)
	);
end entity;


architecture arch of ALU is	
	signal mult : std_logic_vector(2*n-1 downto 0);
begin

	mult <= a*b;
					
	with to_integer(unsigned(op_code)) select
		s <=
			a and b when 0,
			a or b when 1,
			a xor b when 2,			
			a+b when 3,
			a-b when 4,
			mult (n-1 downto 0) when 5,
			a when others;

--s <= a+b;--x"000F";

end;
