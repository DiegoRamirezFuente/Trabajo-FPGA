library ieee;
use ieee.std_logic_1164.all;

entity monoestable is
    port (
        clk: in std_logic;
        rst: in std_logic;
        ent: in std_logic;
        sal: out std_logic
    );
end monoestable;

architecture behavioural of monoestable is
    signal state: std_logic := '0';
    signal counter: integer range 0 to 4 := 0; -- 5 seg con reloj a 100 MHz
begin
    process (clk, rst)
    begin
        if rst = '0' then
            state <= '0';
            counter <= 0;
        elsif rising_edge(clk) then
            if ent = '1' then
             counter <= counter + 1;
                if counter = 4 then
                    state <= '1';
                    counter <= 0;
                end if;
            elsif ent = '0' then
               state <= '0';
               counter <= 0; 
            end if;
        end if;
    end process;

    sal <= state;
end behavioural;