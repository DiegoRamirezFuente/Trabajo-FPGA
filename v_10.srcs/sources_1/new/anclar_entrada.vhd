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
  tiempo: in integer;
  salida: out std_logic
  );
end anclar_entrada;

architecture Behavioral of anclar_entrada is
    signal state: std_logic := '0';
    signal counter: integer :=0;
begin

process (clk, rst)
    begin
    
     
     if rst = '0' then
        counter <= 0;  
     elsif rising_edge(clk) then
     
        if entrada='1' then
            counter <= tiempo +1;
        end if;
        counter <= (counter-1);
        
        if counter = 1 then
            state<='1';
        elsif counter=0 then
            state<='0';
        end if;
    end if;
     
end process;
    
salida <= state;

end Behavioral;