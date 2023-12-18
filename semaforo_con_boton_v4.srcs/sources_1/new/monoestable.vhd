library ieee;
use ieee.std_logic_1164.all;

entity monoestable is
    port (
        clk: in std_logic;
        rst: in std_logic;
        ent: in std_logic;
        BOTON_START : in std_logic;
        temp: in integer;-- tiempo que se mantiene fijo
        sal: out std_logic
    );
end monoestable;

architecture behavioural of monoestable is
    signal state: std_logic := '0';
    signal counter: integer range 0 to 30; -- 5 seg con reloj a 100 MHz
    signal tiempo: integer range 0 to 10 := 6;
    signal soporte_finaliz: integer := 0;
    
begin
    process (clk, rst)
    begin
    
     if ent='0' then
        counter <= 0;
     end if;   
           
    if  BOTON_START = '1' then
            if state = '1'  and soporte_finaliz = 2 then
              state <= '0';
              soporte_finaliz <= 0;
             end if;
        if ent='1' then    
            if rst = '0' then
                state <= '0';
                counter <= 0;
            elsif rising_edge(clk) then
            
            if soporte_finaliz = 0 then
             counter <= counter + 1;
            elsif soporte_finaliz = 1 then
             soporte_finaliz <= 2;
            end if;
             
             
                if counter = tiempo-2 then
                    state <= '1';
                    soporte_finaliz <=1;
                    counter <= 0;
                end if;
            end if;
        end if;
        end if;
    end process;
    
    tiempo<=temp; 
    sal <= state;
end behavioural;