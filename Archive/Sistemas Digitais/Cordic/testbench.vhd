library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is 
end testbench;
	
architecture arch of testbench is    
    signal x,y,z       : signed(15 downto 0);
    signal clk         : std_logic;
    signal reset       : std_logic;
    signal xo,yo    : signed(15 downto 0) := 16x"0000";

    
begin

c : entity work.cordic port map(
    x,y,z,
    clk,
    reset,
    xo,yo
);    


process
begin
    x <= x"0100";
    y <= x"0000";
    z <= x"0000";
    wait for 10ns;

    for j in 0 to 89 loop    
        z <= z + 256;

        reset <= '1', '0' after 10 ns;

        for i in 20 downto 0 loop
            clk<='1';
            wait for 50 ns;
            clk<='0';
            wait for 50 ns;
        end loop;
    end loop;
wait;    
end process;


end arch;