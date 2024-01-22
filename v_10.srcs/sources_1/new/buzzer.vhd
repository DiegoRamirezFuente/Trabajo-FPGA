----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2023 10:53:49
-- Design Name: 
-- Module Name: buzzer - Behavioral
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



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity buzz is
  port (
    modo:in std_logic;
    enable_buzz:in std_logic;
    clk : in std_logic;
    buzzer : out std_logic
  );
end buzz;

architecture Behavioral of buzz is
  signal a : std_logic := '0';
  
begin
  process(clk)
    variable i : integer := 0;
    variable f:integer:=1e8;
  begin
    if rising_edge(clk) then
    if enable_buzz ='1' then
    if modo='1' then
    f:=1e8;
    else
    f:=5e7;
    end if;
     i := i + 1;
      if i <= f/2 then
        a <= '1';
      elsif i > f/2 and i < f then
        a <= '0';
      elsif i = f then
        i := 0;
      end if;
      else a<='0';
    end if;
    end if;
  end process;

  buzzer <= a;

end Behavioral;