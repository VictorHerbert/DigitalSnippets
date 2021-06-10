library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity cordic is
    port(
        x,y,z       : in signed(15 downto 0);
        clk         : in std_logic;
        reset       : in std_logic;
        xo,yo    : out signed(15 downto 0)
    );
end cordic;

architecture arch of cordic is
    signal xn,yn,zn : signed(15 downto 0);
    signal ax,ay,az : signed(31 downto 0);

    type lut is array (15 downto 0) of signed(15 downto 0);
    signal lt : lut := (
        x"2d00", x"1a90", x"0e09", x"0720", x"0393", x"01ca", x"00e5", x"0072",
        x"0039", x"001c", x"000e", x"0007", x"0003", x"0001", x"0000", x"0000"
    );    
    signal tan : lut;

begin
    
    process(clk, reset)
        variable counter : integer := 0;
    begin
    if(reset = '1') then
        xn <= x;
        yn <= y;
        zn <= z;
        tan <= lt;
		  
        counter := 0;
    elsif(falling_edge(clk)) then
        if(counter < 17) then
            if(zn(15) = '0') then
                xn <= signed(xn) - shift_right(yn,counter);
                yn <= signed(yn) + shift_right(xn,counter);
                zn <= zn - tan(15);
            else
                xn <= xn + shift_right(yn,counter);
                yn <= yn - shift_right(xn,counter);
                zn <= zn + tan(15);
            end if;
            
            counter := counter + 1;
            tan(15 downto 1) <= tan(14 downto 0);
        else
            ax <= xn*x"009d"; --9d
            ay <= yn*x"009d";
            
            --xo <= xn;
            --yo <= yn;
            --zo <= zn;

            xo <= ax(23 downto 8);
            yo <= ay(23 downto 8);
        end if;
    end if;
    end process;
     
end arch;
     