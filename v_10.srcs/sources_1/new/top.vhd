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
 PUSHBUTTON_TOP:in std_logic;
 BOTON_ESPERA : in  std_logic;
 SENSOR_TOP: in std_logic;
 V_SAL_TOP: OUT std_logic_vector(7 DOWNTO 0);
 RGB_COCHES_TOP: out std_logic_vector(2 downto 0);
 RGB_PEAT_TOP: out std_logic_vector(2 downto 0);
 segment_top : OUT std_logic_vector(6 DOWNTO 0);
 buzz_top: out std_logic;
 LUZ_ESPERA: out std_logic
 --SEM_TOP : out std_logic_vector(5 downto 0)
 );
end top;

architecture Behavioral of top is
COMPONENT monoestable IS
GENERIC(temp:integer:=0);
 PORT ( 
 clk: in std_logic;
 rst: in std_logic;
 ent: in std_logic;
 BOTON_START : in std_logic;
 sal: out std_logic
 );
END COMPONENT;

COMPONENT anclar_entrada IS
 PORT ( 
  clk: in std_logic;
  rst: in std_logic;
  entrada: in std_logic;
  tiempo: in integer;
  salida: out std_logic
  );
END COMPONENT;

COMPONENT maquina_estados is
 PORT (
 RESET : in std_logic;
 CLK : in std_logic;
 BOTON_INI : in std_logic;
 PUSHBUTTON: in std_logic;
 SENSOR:in std_logic;
 TIEMPO1: in std_logic;
 TIEMPO2: in std_logic;
 TIEMPO3: in std_logic;
 TIEMPO4: in std_logic;
 TIEMPO_ESPERA: in std_logic;
 SEM : out std_logic_vector(5 downto 0);
 
 V_COCHES : out std_logic;
 V_PEAT : out std_logic;
 AMBAR: out std_logic;
 PARP: out std_logic;
 ROJO_ROJO : out std_logic
 );
END COMPONENT;

 component top_rgb
    port (
        CLK_RGB : in std_logic;
        RESET_RGB:in std_logic;
        sel_rgb: in std_logic_vector(5 downto 0);
        RGB_COCHES_RGB : out std_logic_vector (2 downto 0);
        RGB_PEAT_RGB : out std_logic_vector (2 downto 0)
    );
    end component;
    
    COMPONENT top_display IS
 PORT ( 
 clk_disp:in std_logic;
 reset_disp:in std_logic;
 v_sal : OUT std_logic_vector(7 DOWNTO 0);
 segment : OUT std_logic_vector(6 DOWNTO 0);
 enable_disp: in std_logic;
 modo_buzz: in std_logic;
 buzz_disp: OUT std_logic
 );
 END COMPONENT;

COMPONENT debounce IS
    port(
        clk_in     :  in std_logic;
        reset_in   :  in std_logic;
        button_in  :  in std_logic;
        button_out : out std_logic
    );
END COMPONENT;

COMPONENT delay IS
GENERIC(temp:integer:=0);
 PORT ( 
 clk: in std_logic;
 rst: in std_logic;
 ent: in std_logic;
 sal_tiempo_proceso: out std_logic;
 BOTON_START : in std_logic;
 sal: out std_logic
 );
END COMPONENT;

signal vc_signal: STD_LOGIC;
signal vp_signal: STD_LOGIC;
signal vam_signal: STD_LOGIC;
signal vparp_signal: STD_LOGIC;
signal vrr_signal: STD_LOGIC;
signal vapv_signal: STD_LOGIC;
signal vverdeparp_signal:STD_LOGIC;
signal v_cambio_boton_signal: STD_LOGIC;
signal v_cambio_boton_signal_debouncer: STD_LOGIC;
signal temp1: STD_LOGIC;
signal temp2: STD_LOGIC;
signal temp3: STD_LOGIC;
signal temp4: STD_LOGIC;
signal temp_cambio: STD_LOGIC;
signal sel_signal : std_logic_vector(5 downto 0) := (others => '0');
signal enable:std_logic;
signal rgb_coches_signal : std_logic_vector(2 downto 0);
signal rgb_peat_signal : std_logic_vector(2 downto 0);
signal pushbutton_deb,boton_inicio_deb:std_logic;
constant tiempo1: integer := 20e8;-- verde coches
constant tiempo2: integer := 10e8;-- verde peatones
constant tiempo_cambio: integer := 4e8;-- tiempo en verde coches una vez que se ha pulsado boton de xcambio a paso peatones
constant tiempo3: integer := 10e8;-- parapadeo verde/ambar
constant tiempo4: integer := 5e8;-- tiempo seguridad rojo-rojo

begin
vapv_signal<=vam_signal or vparp_signal;
vverdeparp_signal <= vp_signal or vparp_signal;

debounce_pushbutton: debounce port map(
        clk_in => CLK_TOP,
        reset_in => RESET_TOP,
        button_in => PUSHBUTTON_TOP,
        button_out => pushbutton_deb
    );
    
    debounce_boton_ini: debounce port map(
        clk_in => CLK_TOP,
        reset_in => RESET_TOP,
        button_in => BOTON_INICIO,
        button_out => boton_inicio_deb
    );
    
 tiempo_verde_peatones_espera_boton: delay 
GENERIC MAP(temp=>tiempo_cambio)
 PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 BOTON_START => boton_inicio_deb,
 sal_tiempo_proceso => LUZ_ESPERA,
 ent =>pushbutton_deb,
 sal => temp_cambio
 );
 

maquina: maquina_estados PORT MAP (
 RESET => RESET_TOP,
 CLK => CLK_TOP,
 BOTON_INI => boton_inicio_deb,
 PUSHBUTTON => pushbutton_deb,
 --BOTON_ESPERA_PEAT =>  BOTON_ESPERA,
 SENSOR => SENSOR_TOP,
 TIEMPO1 => temp1,
 TIEMPO2 => temp2,
 TIEMPO3 => temp3,
 TIEMPO4 => temp4,
 TIEMPO_ESPERA => temp_cambio,
 SEM => sel_signal,
 V_COCHES => vc_signal,
 V_PEAT => vp_signal,
 AMBAR=> vam_signal,
 PARP=> vparp_signal,
 ROJO_ROJO => vrr_signal
 );
 
anclar_pulso_boton_espere_verde: anclar_entrada PORT MAP (  
  clk => CLK_TOP,
  rst => RESET_TOP,
  entrada => BOTON_ESPERA,
  tiempo => tiempo_cambio,
  salida => v_cambio_boton_signal
);

 
 tiempo_verde_coches: monoestable 
 GENERIC MAP(temp=>tiempo1)
 PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 BOTON_START => boton_inicio_deb,
 ent => vc_signal,
 sal => temp1
 );
 
 tiempo_verde_peatones: monoestable 
 GENERIC MAP(temp=>tiempo2)
 PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 BOTON_START => boton_inicio_deb,
 ent => vp_signal,
 sal => temp2
 );
 
-- tiempo_verde_peatones_espera_boton: monoestable 
--  GENERIC MAP(temp=>tiempo_cambio)
-- PORT MAP ( 
-- clk => CLK_TOP,
-- rst => RESET_TOP,
-- BOTON_START => boton_inicio_deb,
-- ent => v_cambio_boton_signal,
-- sal => temp_cambio
-- );
 
 tiempo_ambar_parp_verde: monoestable
  GENERIC MAP(temp=>tiempo3)
 PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 ent => vapv_signal,
 BOTON_START => boton_inicio_deb,
 sal => temp3
 );
 
 tiempo_seguridad_r_r: monoestable 
  GENERIC MAP(temp=>tiempo4)
 PORT MAP ( 
 clk => CLK_TOP,
 rst => RESET_TOP,
 ent => vrr_signal,
 BOTON_START => boton_inicio_deb,
 sal => temp4
 );
 
 uut: top_rgb port map (
        CLK_RGB => CLK_TOP,
        RESET_RGB => RESET_TOP,
        sel_rgb => sel_signal,
        RGB_COCHES_RGB => rgb_coches_signal,
        RGB_PEAT_RGB => rgb_peat_signal
    );
    
    cuenta_atras: top_display
 PORT MAP( 
 clk_disp => CLK_TOP,
 reset_disp => RESET_TOP,
 v_sal => V_SAL_TOP,
 segment => segment_top,
 enable_disp => vverdeparp_signal,
 modo_buzz => vp_signal,
 buzz_disp => buzz_top
 );
 
    RGB_COCHES_TOP<=rgb_coches_signal;
    RGB_PEAT_TOP<=rgb_peat_signal;
    
end Behavioral;
