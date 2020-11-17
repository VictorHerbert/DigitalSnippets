library ieee;
use ieee.std_logic_1164.all;


entity full_adder is
	port(
		a,b 	: in std_logic;
		s 		: out std_logic;
		cin	: in std_logic;
		cout 	: out std_logic
	);
end entity;


architecture arch of full_adder is
	signal int_sig : std_logic;
begin
	int_sig <= (a xor b);
	s <= (cin xor int_sig);
	cout <= (a and b) or (int_sig and cin);
end arch;




