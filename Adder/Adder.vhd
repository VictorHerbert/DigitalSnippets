library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- for adding vectors

entity Adder is
	generic(
		n : integer := 8;
		arch : integer := 0 -- architecture chooser
	);
	port(
		a,b 	: in std_logic_vector(n-1 downto 0);
		s 		: out std_logic_vector(n-1 downto 0);
		cin 	: in std_logic;
		cout 	: out std_logic
	);
end entity;

architecture arch of Adder is
	component ripple_carry_adder_no_cin is
		generic(
			n : integer
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cout 	: out std_logic
		);
	end component;
	
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
	
	component select_carry_adder_topology is
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
	end component;
	
	component look_ahead_carry_topology is
		generic(
			n : integer
		);
		port(
			a,b : in std_logic_vector(n-1 downto 0);
			s : out std_logic_vector(n-1 downto 0);
			cout : out std_logic
		);
	end component;
	
	component ripple_carry_adder_sub is
		generic(
			n : integer
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cin	: in std_logic;
			cout : out std_logic;
			op : in std_logic
		);
	end component;
	
	
	signal op_code : std_logic := '1';
	
		
begin

	native_architecture: if arch = 0 generate
		s <= a+b;
	end generate;

	ripple_architecture: if arch = 1 generate
		RippleAdderArch : ripple_carry_adder
			generic map (n)
			port map(
				a,b,
				s,
				cin,
				cout
			);
	end generate;
	
	select_architecture: if arch = 2 generate
		SelectAdderArch : select_carry_adder
			generic map (n)
			port map(
				a,b,
				s,
				cin,
				cout
			);
	end generate;
	
	selectTopology_architecture: if arch = 3 generate
		SelectAdderTopologyArch : select_carry_adder_topology
			generic map (n)
			port map(
				a,b,
				s,
				cin,
				cout
			);
	end generate;
	
	lookTopology_architecture: if arch = 4 generate
		lookaheadAdderTopologyArch : look_ahead_carry_topology
			generic map (n)
			port map(
				a,b,
				s,				
				cout
			);
	end generate;
	
	ripple_add_sub_architecture: if arch = 5 generate
		RippleAdderSubArch : ripple_carry_adder_sub
			generic map (n)
			port map(
				a,b,
				s,
				cin,
				cout,
				op_code
			);
	end generate;

	

end;