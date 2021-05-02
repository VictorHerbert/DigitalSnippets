library ieee;
use ieee.std_logic_1164.all;

entity look_ahead_carry is
	port(
		p, g: in std_logic_vector(3 downto 0);
		s: out std_logic_vector(3 downto 0);
		cin: in std_logic;
		cout: out std_logic
	);
end entity;

architecture arch of look_ahead_carry is
	signal c: std_logic_vector(4 downto 0);
	
begin
	
	c(0) <= cin;
	c(1) <= g(0) or (p(0) and cin);
	c(2) <= g(1) or (p(1)and g(0)) or (p(1)and p(0) and cin);
	c(3) <= g(2) or (p(2)and g(1)) or (p(2)and p(1) and g(0)) or (p(2)and p(1) and p(0) and cin);
	c(4) <= g(3) or (p(3) and g(2)) or (p(3)and p(2)and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3)and p(2) and p(1) and p(0) and cin); 

	output: for i in 0 to 3 generate
		s(i) <= p(i) xor c(i);
	end generate;
	
	cout <= c(4);

end arch;