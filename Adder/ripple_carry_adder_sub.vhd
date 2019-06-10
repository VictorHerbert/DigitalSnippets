library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_adder_sub is
	generic(
		n : integer := 8
	);
	port(
		a,b 	: in std_logic_vector(n-1 downto 0);
		s 		: out std_logic_vector(n-1 downto 0);
		cin	: in std_logic;
		cout : out std_logic;
		op : in std_logic
	);
end entity;

architecture arch of ripple_carry_adder_sub is


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
	
	signal carry_out : std_logic_vector(n downto 0);
	signal b_ready : std_logic_vector(n-1 downto 0);
	
begin

	--xors: for i in 0 to n-1 generate
		--b_ready(i) <= b(i) xor op;
	--end generate;
		
	with op select b_ready <= 
		not b when '1',
		b when others;
		

	with op select carry_out(0) <= 
		'1' when '1',
		cin when others;

	--add1 : half_adder port map(a(0),b(0), s(0), carry_out(0));
	
	addGen: for i in 0 to n-1 generate
		adds: full_adder port map(a(i), b_ready(i), s(i), carry_out(i), carry_out(i+1));
	end generate;

	cout <= carry_out(n);

end architecture;