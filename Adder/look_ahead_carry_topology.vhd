library ieee;
use ieee.std_logic_1164.all;

entity look_ahead_carry_topology is
	generic(
		n : integer
	);
	port(
		a,b : in std_logic_vector(n-1 downto 0);
		s : out std_logic_vector(n-1 downto 0);
		cout : out std_logic
	);
end entity;

architecture arch of look_ahead_carry_topology is
	
	component half_adder is
		port(
			a,b 	: in std_logic;
			s 		: out std_logic;
			cout 	: out std_logic
		);
	end component;
	
	component look_ahead_carry is
		port(
			p, g: in std_logic_vector(3 downto 0);
			s: out std_logic_vector(3 downto 0);
			cin: in std_logic;
			cout : out std_logic
		);
	end component;
	
	signal p,g: std_logic_vector(n-1 downto 0);
	signal carry: std_logic_vector(n/4 downto 0);

begin

	half_adders: for i in 0 to n-1 generate
		half_adder_i: half_adder port map(a(i), b(i), p(i), g(i));
	end generate;
	
	look_aheads: for i in 0 to n/4-1 generate
		look_ahead_i: look_ahead_carry port map(
			p(4*i+3 downto 4*i),
			g(4*i+3 downto 4*i),
			s(4*i+3 downto 4*i),
			carry(i),
			carry(i+1)
		);
	end generate;
	
	carry(0) <= '0';
	cout <= carry(n/4-1);
	
	
	

end arch;