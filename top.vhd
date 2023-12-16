----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2023 09:55:32
-- Design Name: 
-- Module Name: top - Behavioral
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

ENTITY top IS
 PORT (
 RESET_TOP : in std_logic;
 CLK_TOP : in std_logic;
 BOTON_TOP : in std_logic;
 SENSOR_TOP:in std_logic;
 SEM_TOP : out std_logic_vector(5 downto 0)
 );
end top;

architecture Behavioral of top is
COMPONENT monoestable IS
 PORT ( 
 clk: in std_logic;
 rst: in std_logic;
 ent: in std_logic;
 sal: out std_logic
 );
END COMPONENT;

COMPONENT maquina_estados is
 PORT (
 RESET : in std_logic;
 CLK : in std_logic;
 PUSHBUTTON : in std_logic;
 SENSOR:in std_logic;
 TIEMPO:in std_logic;
 SEM : out std_logic_vector(5 downto 0);
 VPEAT : out std_logic
 );
END COMPONENT;

signal vp_signal: STD_LOGIC;
signal temp: STD_LOGIC;

begin

maquina: maquina_estados PORT MAP (
 RESET => RESET_TOP,
 CLK => CLK_TOP,
 PUSHBUTTON => BOTON_TOP,
 SENSOR => SENSOR_TOP,
 TIEMPO => temp,
 SEM => SEM_TOP,
 VPEAT => vp_signal
 );
 
 tiempo_verde: monoestable PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 ent => vp_signal,
 sal => temp
 );
end Behavioral;
