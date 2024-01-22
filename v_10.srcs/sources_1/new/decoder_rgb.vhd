----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2023 10:07:09
-- Design Name: 
-- Module Name: decoder_rgb - Behavioral
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

entity decoder_rgb is
port (
    sel: in std_logic_vector(5 downto 0);
    RGB_COCHES : out std_logic_vector (2 downto 0);
    RGB_PEAT : out std_logic_vector (2 downto 0)
);
end decoder_rgb;

architecture Behavioral of decoder_rgb is
signal sem_coch,sem_peat: std_logic_vector(2 downto 0);
begin
sem_coch <= sel(5 downto 3);
sem_peat <= sel(2 downto 0); 
WITH sem_coch SELECT
RGB_COCHES <=
"100" WHEN "001",
"010" WHEN "100",
"001" WHEN "010",
"000" WHEN others;

WITH sem_peat 
SELECT
RGB_PEAT <=
"100" WHEN "001",
"010" WHEN "100",
"111" WHEN "010",
"000" WHEN others;
end Behavioral;
