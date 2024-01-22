library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_rgb is
port (
    CLK : in std_logic;
    RESET:in std_logic;
    RGB_IN : in std_logic_vector (2 downto 0);
    RGB_OUT : out std_logic_vector (2 downto 0)
);
end control_rgb;

architecture Behavioral of control_rgb is

signal count : integer range 0 to 1e8 := 0;
signal duty : integer := 8e7;
signal parpadeo : std_logic_vector(1 downto 0):="11";
begin
 process (CLK, RESET,RGB_IN)
    begin
        if RESET = '0' then
            count <= 0;
            parpadeo<="00";
        elsif rising_edge(clk) then
        if RGB_IN="111" then
        if count=1e8 then
        count<=0;
        else
        count <= count +1;
         end if;
            if count >= duty then
                parpadeo <= "00";
            else
                parpadeo <= "01";
            end if;
        else parpadeo<="11";
        end if;
        end if;
    end process;
    
    RGB_OUT <= RGB_IN WHEN parpadeo = "11" ELSE
        "000" WHEN parpadeo = "00" ELSE
        "010" WHEN parpadeo = "01";
           
           
end behavioral;