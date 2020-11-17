
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is 
end testbench;
	
architecture arch of testbench is
    signal x,y,z       : signed(15 downto 0);
    signal xo,yo    : signed(15 downto 0);
begin

c : entity work.cordic port map(
    x,y,z,
    xo,yo
);    



process
begin
	
  x <= x"0100";
  y <= x"0000";
  z <= x"0000";
  wait for 10 ns;
  for i in 10 downto 0 loop
  	z <= z + x"0100";
    wait for 1 ns;
  end loop;

wait for 50 ns;
wait;
end process;

end arch;