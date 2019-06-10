library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_adder_no_cin is
	generic(
		n : integer
	);
	port(
		a,b 	: in std_logic_vector(n-1 downto 0);
		s 		: out std_logic_vector(n-1 downto 0);
		cout : out std_logic
	);
end entity;

architecture arch of ripple_carry_adder_no_cin is
	component half_adder is
		port(
			a,b 	: in std_logic;
			s 		: out std_logic;
			cout 	: out std_logic
		);
	end component;
	
	component full_adder is
		port(
			a,b 	: in std_logic;
			s 		: out std_logic;
			cin	: in std_logic;
			cout 	: out std_logic
		);
	end component;
	
	signal carry_out : std_logic_vector(n-1 downto 0) ;
begin

	add1 : half_adder port map(a(0),b(0), s(0), carry_out(0));
	
	addGen: for i in 1 to (n-1) generate
		adds: full_adder port map(a(i), b(i), s(i), carry_out(i-1), carry_out(i));
	end generate;

	cout <= carry_out(n-1);

end architecture;