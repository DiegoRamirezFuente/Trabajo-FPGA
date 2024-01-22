library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maquina_estados is
 port (
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
 SEM : out std_logic_vector(5 downto 0);--(VC,AC,RC,VP,PP,RP)
 V_COCHES : out std_logic;
 V_PEAT : out std_logic;
 AMBAR: out std_logic;
 PARP: out std_logic;
 ROJO_ROJO : out std_logic
 );
end maquina_estados;

architecture behavioral of maquina_estados is

 type STATES is (S10,S0,S1,S2 ,S3,S4,S5);
 signal current_state: STATES := S0;
 signal next_state: STATES;
 

 signal vc,vp,vam,vparp,vrr: std_logic;
 
begin
state_register: process (RESET, CLK)
begin
    if reset = '0' then
        current_state <= S10;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
end process;

 
nextstate_decod: process (BOTON_INI, current_state, TIEMPO1, TIEMPO2, TIEMPO3, TIEMPO4, TIEMPO_ESPERA)
 begin
 
 next_state <= current_state;
 
 case current_state is
 
 when S10 => --Rojo coches y rojo peatones
 if BOTON_INI = '1' then
 next_state <= S0;
 end if;
 
 when S0 => --Rojo coches y rojo peatones
 if TIEMPO4 = '1' then
 next_state <= S1;
 end if;
 
 when S1 => --Verde coches y rojo peatones
 if (TIEMPO1='1' or TIEMPO_ESPERA='1') then
 next_state <= S2;
 end if;
 
 when S2 => --Ambar coches y rojo peatones
 if TIEMPO3 = '1' then
 next_state <= S3;
 end if;
 
 when S3 => --Rojo coches y rojo peatones
 if TIEMPO4 = '1' then
 next_state <= S4; 
 end if;
 
 when S4 => --Rojo coches y verde peatones
 if TIEMPO2 = '1' then
 next_state <= S5;
 end if;
 
 when S5 => --Rojo coches y parpadeo peatones
 if TIEMPO3 = '1' then
 next_state <= S0; 
 end if;
 
 when others => 
 next_state <= S0;
 end case;
 end process;
 
 output_decod: process (current_state)
 begin
 SEM <= (OTHERS => '0');
 
 case current_state is
 
 when S10 => --Rojo coches y rojo peatones
 SEM <= "001001";
    vc<='0';
    vp<='0';
    vam<='0';
    vparp<='0';
    vrr<='0';

when S0 => --Rojo coches y rojo peatones
 SEM <= "001001";
    vc<='0';
    vp<='0';
    vam<='0';
    vparp<='0';
    vrr<='1';
 
 when S1 => --Verde coches y rojo peatones
 SEM <= "100001";
 vc<='1';
 vp<='0';
 vam<='0';
 vparp<='0';
 vrr<='0';

 when S2 => --Ambar coches y rojo peatones
 SEM <= "010001";
 vc<='0';
 vp<='0';
 vam<='1';
 vparp<='0';
 vrr<='0';
 
 when S3 => --Rojo coches y rojo peatones
 SEM <= "001001";
 vc<='0';
 vp<='0';
 vam<='0';
 vparp<='0';
 vrr<='1';
 
 when S4 => --Rojo coches y verde peatones
 SEM <= "001100";
 vc<='0';
 vp<='1';
 vam<='0';
 vparp<='0';
 vrr<='0';
 
 when S5 => --Rojo coches y parpadeo peatones
 SEM <= "001010";
 vc<='0';
 vp<='0';
 vam<='0';
 vparp<='1';
 vrr<='0';
 
 when others =>
 SEM <= (OTHERS => '0');
 vc<='0';
 vp<='0';
 vrr<='0';
 vam<='0';
 vparp<='0';
 
 end case;
 end process;
 
 V_COCHES<=vc;
 V_PEAT<=vp;
 AMBAR<=vam;
 PARP<=vparp;
 ROJO_ROJO<=vrr;
 
end behavioral;