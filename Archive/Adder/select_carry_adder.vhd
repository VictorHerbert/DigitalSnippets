library ieee;
use ieee.std_logic_1164.all;

entity select_carry_adder is
	generic(
		n : integer
	);
	port(
		a,b	: in std_logic_vector(n-1 downto 0);
		s 		: out std_logic_vector(n-1 downto 0);
		cin	: in std_logic;
		cout	: out std_logic
	);
end entity;

architecture arch of select_carry_adder is

	component ripple_carry_adder is
		generic(
			n : integer
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cin	: in std_logic;
			cout 	: out std_logic
		);
	end component;
	
	component ripple_carry_adder_no_cin is
		generic(
			n : integer
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cout : out std_logic
		);
	end component;
	
	signal zero_sig : std_logic := '0';
	signal one_sig : std_logic := '1';
	
	signal no_carry_cout : std_logic;
	signal carry_cout : std_logic;
	

	signal s_carry : std_logic_vector(n-1 downto 0);
	signal s_no_carry : std_logic_vector(n-1 downto 0);
	
	
begin

	
	no_carry_adder: ripple_carry_adder_no_cin 
		generic map(n)
		port map(a, b, s_no_carry, no_carry_cout);
		
	carry_adder: ripple_carry_adder 
		generic map(n)
		port map(a, b, s_carry, one_sig, carry_cout);
		
	with cin select cout <=
		no_carry_cout when '0',
		carry_cout when '1';
		
	carry_chooser: for i in 0 to (n-1) generate
		with cin select s(i) <=
			s_no_carry(i) when '0',
			s_carry(i) when '1';
	end generate;
    
	
end architecture;