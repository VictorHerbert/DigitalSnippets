library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity cordic is
    port(
        x,y,z       : in signed(15 downto 0);
        clk         : in std_logic;
        reset       : in std_logic;
        xo,yo,zo    : out signed(15 downto 0)
    );
end cordic;

architecture arch of cordic is
    signal ax,ay,az : signed(31 downto 0);

    type lut is array (15 downto 0) of signed(15 downto 0);
    signal lt : lut := (
        x"2d00", x"1a90", x"0e09", x"0720", x"0393", x"01ca", x"00e5", x"0072",
        x"0039", x"001c", x"000e", x"0007", x"0003", x"0001", x"0000", x"0000"
    );
    
    signal tan : lut;

    signal xn, yn, zn : lut;

begin
    xn(0) <= x;
    yn(0) <= y;
    zn(0) <= z;

    ax <= xn(15)*x"009d";
    ay <= yn(15)*x"009d";
    
    xo <= ax(23 downto 8);
    yo <= ay(23 downto 8);
    
    
    f : for i in 0 to 14 generate
        process(zn)
        begin
        if(zn(i)(15) = '0') then
            xn(i+1) <= signed(xn(i)) - shift_right(yn(i),i);
            yn(i+1) <= signed(yn(i)) + shift_right(xn(i),i);
            zn(i+1) <= zn(i) - lt(i);
        else
            xn(i+1) <= xn(i) + shift_right(yn(i),i);
            yn(i+1) <= yn(i) - shift_right(xn(i),i);
            zn(i+1) <= zn(i) + lt(i);
        end if;
        end process;
    end generate;

end arch;
     