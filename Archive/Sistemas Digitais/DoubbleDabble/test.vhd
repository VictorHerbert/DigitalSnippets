library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is 
end testbench;
	
architecture arch of testbench is
    signal binary   : std_logic_vector(7 downto 0) := x"FF";
  	signal clk      : std_logic;
  	signal reset    : std_logic;
  	signal a, b, c  : std_logic_vector(3 downto 0);
	signal done     : std_logic;
begin
    
    d : entity work.dd port map(
        binary,
        clk,
        reset,
        a, b, c,
        done,
    );

process
begin
    reset <= '1',
        '0' after 10 ns;
        
    for i in 7 downto 0 loop
        clk<='1';
        wait for 50 ns;
        clk<='0';
        wait for 50 ns;
    end loop;
    wait;
end process;


end testbench;