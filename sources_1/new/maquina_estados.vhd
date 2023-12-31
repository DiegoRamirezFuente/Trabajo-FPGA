library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maquina_estados is
 port (
 RESET : in std_logic;
 CLK : in std_logic;
 PUSHBUTTON : in std_logic;
 SENSOR:in std_logic;
 TIEMPO: in std_logic;
 
 SEM : out std_logic_vector(5 downto 0);--(VC,AC,RC,VP,PP,RP)
 VPEAT : out std_logic 
 );
end maquina_estados;

architecture behavioral of maquina_estados is
 type STATES is (S0,S1,S2 ,S3,S4,S5,S6 );
 signal current_state: STATES := S0;
 signal next_state: STATES;
 signal vp: std_logic;
 
begin
 state_register: process (RESET, CLK)
 
 begin
  if reset='0' then
  current_state<=S0;
  elsif rising_edge(clk) then
        current_state<=next_state; 
  end if;
 end process;
 
nextstate_decod: process (PUSHBUTTON, current_state)
 begin
 next_state <= current_state;
 case current_state is
 when S0 => --Rojo coches y rojo peatones
 next_state <= S1;
 when S1 => --Verde coches y rojo peatones
 if PUSHBUTTON = '1'  then
 next_state <= S2;
 end if;
 when S2 => --Ambar coches y rojo peatones
 next_state <= S3;
 when S3 => --Rojo coches y rojo peatones
 next_state <= S4; 
 when S4 => --Rojo coches y verde peatones
 if TIEMPO = '1' then
 next_state <= S5;
 end if;
 when S5 => --Rojo coches y parpadeo peatones
 next_state <= S6;
 when S6 => --Rojo coches y rojo peatones
 next_state <= S1; 
 when others => 
 next_state <= S0;
 end case;
 end process;
 
 output_decod: process (current_state)
 begin
 SEM <= (OTHERS => '0');
 case current_state is
  when S0 => --Rojo coches y rojo peatones
 SEM <= "001001";
 when S1 => --Verde coches y rojo peatones
 SEM <= "100001";
 when S2 => --Ambar coches y rojo peatones
 SEM <= "010001";
 when S3 => --Rojo coches y rojo peatones
 SEM <= "001001";
 when S4 => --Rojo coches y verde peatones
 SEM <= "001100";
 vp <= '1';
 when S5 => --Rojo coches y parpadeo peatones
 SEM <= "001010";
 vp <= '0';
 when S6 => --Rojo coches y rojo peatones
 SEM <= "001001";
 when others =>
 SEM <= (OTHERS => '0');
 end case;
 end process;
 
 VPEAT<=vp;
 
end behavioral;