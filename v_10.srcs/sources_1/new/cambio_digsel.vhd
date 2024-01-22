----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2023 20:06:18
-- Design Name: 
-- Module Name: cambio_digsel - Behavioral
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
entity cambio_digsel is
    port (
        clk : in std_logic;
        enable_digsel:in std_logic;
        segment_uni_in:in std_logic_vector(6 downto 0);
        segment_dec_in:in std_logic_vector(6 downto 0);
        digsel : out std_logic_vector(7 downto 0);
        segment_out:out std_logic_vector(6 downto 0)
    );
end cambio_digsel;

architecture Behavioral of cambio_digsel is
    signal counter : integer range 0 to 1e5 := 0;--1e5=1ms
    signal seg :std_logic_vector(6 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
        if enable_digsel='1' then
         if counter = 1e5 then
            counter <= 0;
         else counter<=counter+1;
         end if;
            if counter >= 5e4  then
                digsel <= "11111110";
                seg<=segment_uni_in;
            else
                digsel <= "11111101";
                seg<=segment_dec_in;               
            end if;
            else digsel<="11111111";
            end if;
            end if;
        segment_out<=seg;
    end process;
end Behavioral;