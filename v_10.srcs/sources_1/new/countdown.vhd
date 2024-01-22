----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2023 22:36:22
-- Design Name: 
-- Module Name: countdown - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity countdown is
generic(cuenta:integer);
Port ( 
clk:in std_logic;
reset:in std_logic;
enable:in std_logic;
segundos: out std_logic_vector(3 DOWNTO 0);
fin:out std_logic
);
end countdown;

architecture Behavioral of countdown is
signal contador:integer:=cuenta;--1e9-1;
signal aux:integer:=9;
begin
process (reset, clk)
begin
 if reset = '0' then
 contador <=cuenta;--1e9-1;
 aux<=9;
 fin <= '0';
 elsif rising_edge(clk) then
 fin <= '0';
 if enable = '1' then
 if contador = 0 then
 contador <= cuenta;--1e9-1;--1e9=10s
 else
 contador <= contador-1;
 end if;
 if aux = 0 then
 fin<='1';
 aux <= 9;
 else
 aux <= aux-1;
 end if;
 end if;
 end if;
end process;

segundos <= std_logic_vector(to_unsigned(contador/1e8,4));
end Behavioral;
