----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2023 18:36:44
-- Design Name: 
-- Module Name: anclar_entrada - Behavioral
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

entity anclar_entrada is
  Port ( 
  clk: in std_logic;
  rst: in std_logic;
  entrada: in std_logic;
  cond: in std_logic;--condición de cuando se permite que lo considere, en caso de no requerirse meter un 1 lógico
  tiempo: in integer;
  salida: out std_logic
  );
end anclar_entrada;

architecture Behavioral of anclar_entrada is
    signal state: std_logic := '0';
    signal counter: integer :=0;
begin

process (clk, rst, cond)
    begin
    
     if cond='0' then
    
     if entrada='1' and counter = 0 then
        counter <= tiempo+1;
        state<='1';
     end if;  
     
     if counter /= 0 and rising_edge(clk) then
        counter<=counter-1;
        if counter = 1 then
            state<='0';
        end if;
     elsif cond='1' then
        counter <=0;
     end if;
  
     
     end if;        
   
end process;
    
salida <= state;

end Behavioral;
