library ieee;
use ieee.std_logic_1164.all;

entity select_carry_adder_topology is
	generic(
		n : integer;
		block_size : integer := 4
	);
	port(
		a,b	: in std_logic_vector(n-1 downto 0);
		s 		: out std_logic_vector(n-1 downto 0);
		cin	: in std_logic;
		cout	: out std_logic
	);
end entity;

architecture arch of select_carry_adder_topology is
	component ripple_carry_adder is
		generic(
			n : integer
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cin	: in std_logic;
			cout : out std_logic
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

	component select_carry_adder is
		generic(
			n : integer
		);
		port(
			a,b	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cin	: in std_logic;
			cout	: out std_logic
		);
	end component;
	
	signal carry_out : std_logic_vector(n/block_size-1 downto 0);
	
begin

			
	carry_adder: ripple_carry_adder_no_cin
		generic map(block_size)
		port map(
			a(block_size-1 downto 0),
			b(block_size-1 downto 0),
			s(block_size-1 downto 0),
			carry_out(0)
		);
		
	addGen: for i in 1 to (n/block_size-1) generate
		adds: select_carry_adder 
			generic map(block_size)
			port map(
				a(block_size*(i+1)-1 downto block_size*i),
				b(block_size*(i+1)-1 downto block_size*i),
				s(block_size*(i+1)-1 downto block_size*i),
				carry_out(i-1),
				carry_out(i));
	end generate;
	
	cout <= carry_out(n/block_size-1);

	

end;