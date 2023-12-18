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
 BOTON_INICIO : in std_logic;--START interruptor a uno para que funcione el ciclo, de lo contrario modo bloqueo rojo-rojo
 BOTON_ESPERA : in  std_logic;
 SENSOR_TOP: in std_logic;
 SEM_TOP : out std_logic_vector(5 downto 0)
 );
end top;

architecture Behavioral of top is
COMPONENT monoestable IS
 PORT ( 
 clk: in std_logic;
 rst: in std_logic;
 ent: in std_logic;
 BOTON_START : in std_logic;
 temp: in integer;
 sal: out std_logic
 );
END COMPONENT;

COMPONENT anclar_entrada IS
 PORT ( 
  clk: in std_logic;
  rst: in std_logic;
  entrada: in std_logic;
  cond: in std_logic;
  tiempo: in integer;
  salida: out std_logic
  );
END COMPONENT;

COMPONENT maquina_estados is
 PORT (
 RESET : in std_logic;
 CLK : in std_logic;
 BOTON_INI : in std_logic;
 SENSOR:in std_logic;
 TIEMPO1: in std_logic;
 TIEMPO2: in std_logic;
 TIEMPO3: in std_logic;
 TIEMPO4: in std_logic;
 TIEMPO_ESPERA: in std_logic;
 SEM : out std_logic_vector(5 downto 0);
 
 V_COCHES : out std_logic;
 V_PEAT : out std_logic;
 AMBAR_PARPV: out std_logic;
 ROJO_ROJO : out std_logic
 );
END COMPONENT;

signal vc_signal: STD_LOGIC;
signal vp_signal: STD_LOGIC;
signal vapv_signal: STD_LOGIC;
signal vrr_signal: STD_LOGIC;
signal v_cambio_boton_signal: STD_LOGIC;
signal temp1: STD_LOGIC;
signal temp2: STD_LOGIC;
signal temp3: STD_LOGIC;
signal temp4: STD_LOGIC;
signal temp_cambio: STD_LOGIC;
signal tiempo1: integer := 20;-- verde coches --- 100->1s
signal tiempo2: integer := 10;-- verde peatones
signal tiempo_cambio: integer := 5 + 1;-- tiempo en verde coches una vez que se ha pulsado boton de xcambio a paso peatones
signal tiempo3: integer := 8;-- parapadeo verde/ambar
signal tiempo4: integer := 5;-- tiempo seguridad rojo-rojo

begin


maquina: maquina_estados PORT MAP (
 RESET => RESET_TOP,
 CLK => CLK_TOP,
 BOTON_INI => BOTON_INICIO,
 --BOTON_ESPERA_PEAT =>  BOTON_ESPERA,
 SENSOR => SENSOR_TOP,
 TIEMPO1 => temp1,
 TIEMPO2 => temp2,
 TIEMPO3 => temp3,
 TIEMPO4 => temp4,
 TIEMPO_ESPERA => temp_cambio,
 SEM => SEM_TOP,
 V_COCHES => vc_signal,
 V_PEAT => vp_signal,
 AMBAR_PARPV => vapv_signal,
 ROJO_ROJO => vrr_signal
 );
 
anclar_pulso_boton_espere_verde: anclar_entrada PORT MAP (  
  clk => CLK_TOP,
  rst => RESET_TOP,
  entrada => BOTON_ESPERA,
  cond => vrr_signal,
  tiempo => tiempo_cambio,
  salida => v_cambio_boton_signal
);

 
 tiempo_verde_coches: monoestable PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 BOTON_START => BOTON_INICIO,
 ent => vc_signal,
 sal => temp1,
 temp=>tiempo1
 );
 
 tiempo_verde_peatones: monoestable PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 BOTON_START => BOTON_INICIO,
 ent => vp_signal,
 sal => temp2,
 temp=>tiempo2
 );
 
 tiempo_verde_peatones_espara_boton: monoestable PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 BOTON_START => BOTON_INICIO,
 ent => v_cambio_boton_signal,
 sal => temp_cambio,
 temp=>tiempo_cambio
 );
 
 tiempo_ambar_parp_verde: monoestable PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 ent => vapv_signal,
 BOTON_START => BOTON_INICIO,
 sal => temp3,
 temp=>tiempo3
 );
 
 tiempo_seguridad_r_r: monoestable PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 ent => vrr_signal,
 BOTON_START => BOTON_INICIO,
 sal => temp4,
 temp=>tiempo4
 );
 
end Behavioral;
