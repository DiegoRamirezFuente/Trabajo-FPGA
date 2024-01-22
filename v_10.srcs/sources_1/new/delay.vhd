----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2023 11:44:43
-- Design Name: 
-- Module Name: delay - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity delay is
generic(temp: in integer);-- tiempo que se mantiene fijo)
    port (
        clk: in std_logic;
        rst: in std_logic;
        ent: in std_logic;
        BOTON_START : in std_logic;
        sal: out std_logic;
        sal_tiempo_proceso: out std_logic
    );
end delay;

architecture Behavioral of delay is
    signal state: std_logic := '0';
    signal counter : integer :=0;
   -- signal tiempo: integer := 6;
   signal soporte_duracion: std_logic;
    
begin
process (clk, rst)
    begin

      
     if rst = '0' then
          state <= '0';
          counter <= 0;
     elsif rising_edge(clk) then
     
        if ent='1' then
            counter <= temp+1;
            soporte_duracion <= '1';
        end if;
        
        if counter>0 then
            counter <= counter -1;
            soporte_duracion <= '1';
             if counter=1 then
                state<='1';
             end if;
        elsif counter = 0 then
            state<='0';
            soporte_duracion <= '0';
        end if;
     end if;
end process;
    
    sal <= state;
    sal_tiempo_proceso<=soporte_duracion;
    
end  Behavioral;