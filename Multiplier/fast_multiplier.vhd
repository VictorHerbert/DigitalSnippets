library ieee;
use ieee.std_logic_1164.all;


entity fast_multiplier is 
	generic(n : integer := 8);
	port(
		a,b	: in std_logic_vector(n-1 downto 0);
		s		: out std_logic_vector(n-1 downto 0)
	);
end fast_multiplier;


architecture arch of fast_multiplier is 
	component ripple_carry_adder is
		generic(
			n : integer := 8
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			s 		: out std_logic_vector(n-1 downto 0);
			cin	: in std_logic;
			cout  : out std_logic
		);
	end component;
	
	type matrix is array (0 to n-1) of std_logic_vector(n-1 downto 0); 
	
	signal and_res: matrix;
	signal adders_out : matrix;
	signal adders_in : matrix; -- entrada dos somadores
	signal couts : std_logic_vector(n-1 downto 0);
	signal c : std_logic_vector(2*n-1 downto 0);

begin


prod_i: for i in 0 to n-1 generate
	prod_j: for j in 0 to n-1 generate
		and_res(i)(j) <= a(i) and b(j);
	end generate;
end generate;

adders_out(0) <= and_res(0);
couts(0) <= '0';

loop3: for i in 0 to n-2 generate 
	adders_in(i) <= couts(i) & adders_out(i)(n-1 downto 1);
	
	somador:ripple_carry_adder
		port map (
			adders_in(i),
			and_res(i+1),
			adders_out(i+1),
			'0',
			couts(i+1)
		);
		
	c(i) <= adders_out(i)(0);
	
end generate;

c(2*n-1)<= couts(n-1);
c(2*n-2 downto 2*n-2-(n-1))<= adders_out(n-1);	

s <= c(n-1 downto 0);
	
end arch;