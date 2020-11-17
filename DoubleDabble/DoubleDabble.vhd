library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity dd is
    port(
        binary: in std_logic_vector(7 downto 0);
        clk: in std_logic;
        reset : in std_logic;
        a, b, c : out std_logic_vector(3 downto 0);
        done : out std_logic
    );
end dd;

architecture arch of dd is
    type states is (idle, check, shift, finished);
    signal state : states;

    signal data : std_logic_vector(19 downto 0);
begin
    c <= data(11 downto 8);
    b <= data(15 downto 12);
    a <= data(19 downto 16);

    process(clk, reset)
        variable counter : integer := 0;
    begin
    if(reset = '1') then
        data <= x"000" & binary;
        counter := 0;
        state <= check;
        done <= '0';
        state <= idle;
    elsif(falling_edge(clk)) then
        if(state = idle) then
            state <= check;
        elsif(state = check) then
            if(counter = 8) then
                state <= finished;
            else
                if(data(11 downto 8) >= 5) then
                    data(11 downto 8) <= data(11 downto 8) + x"3";
                end if;
                if(data(15 downto 12) >= 5) then
                    data(15 downto 12) <= data(15 downto 12) + x"3";
                end if;

                state <= shift;
            end if;
        elsif(state = shift) then
            data <= data(18 downto 0) & '0';
            counter := counter + 1;
            state <= check;
        elsif(state = finished) then
            done <= '1';
        end if;                
    end if;

    end process;
     

end arch;
     