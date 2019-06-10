entity testbench is
end testbench;

architecture arch of testbench is

	component Divider is
		generic(
			n : integer := 8
		);
		port(
			a,b 	: in std_logic_vector(n-1 downto 0);
			c	 	: out std_logic_vector(n-1 downto 0);
			clk 	: in std_logic;
			reset	: in std_logic;
			ready : out std_logic
		);
	end component;
	
begin

end arch;
