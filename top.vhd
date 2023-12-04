----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2023 16:00:20
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY top IS
 PORT (
 RESET_TOP:IN std_logic;
 CLK_TOP: IN std_logic;
 BOTON:IN std_logic;
 SNS : IN std_logic;
 
 RGB_PEATON : OUT std_logic_vector(2 DOWNTO 0);
 RGB_COCHE : OUT std_logic_vector(2 DOWNTO 0)
 );
END top;

architecture Behavioral of top is

COMPONENT maq_coche IS
 PORT (
 RESET : in std_logic;
 CLK : in std_logic;
 PUSHBUTTON : in std_logic;
 SENSOR:in std_logic;
 SEM_COCH : out std_logic_vector(2 downto 0);
 SEM_ROJO: out std_logic
 );
END COMPONENT;

COMPONENT maq_peaton is
 PORT (
 RESET : in std_logic;
 CLK : in std_logic;
 ROJOCOCHE : in std_logic;
 SEM_PEAT : out std_logic_vector(2 downto 0)
 );
END COMPONENT;

signal color_peaton: std_logic_vector(2 downto 0);
signal color_coche: std_logic_vector(2 downto 0);
signal coche_rojo: STD_LOGIC;

begin

semaforo_coches: maq_coche PORT MAP (
 RESET => RESET_TOP,
 CLK => CLK_TOP,
 PUSHBUTTON => BOTON,
 SENSOR => SNS,
 SEM_COCH => color_coche,
 SEM_ROJO => coche_rojo
 );

semaforo_peaton:maq_peaton PORT MAP ( 
 RESET => RESET_TOP,
 CLK => CLK_TOP,
 ROJOCOCHE => coche_rojo,
 SEM_PEAT =>color_peaton
 );
 
 RGB_COCHE <= color_coche;
 RGB_PEATON <= color_peaton;
 
end Behavioral;

