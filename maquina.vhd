library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2023 15:43:08
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity maq_coche is
 port (
 RESET : in std_logic;
 CLK : in std_logic;
 PUSHBUTTON : in std_logic;
 SENSOR:in std_logic;
 SEM_COCH : out std_logic_vector(2 downto 0);
 SEM_ROJO: out std_logic
 );
end maq_coche;
architecture behavioral of maq_coche is
 type STATES is (VERDE, AMBAR , ROJO);
 signal current_state: STATES := VERDE;
 signal next_state: STATES;
   constant t_rojo : time := 50 ns;
 constant t_ambar : time := 20 ns;
 --constant t_verde : time := 70 ns;
 constant t_prudencial : time := 10 ns;
begin
 state_register: process (RESET, CLK)
 begin
  if reset='0' then
  current_state<=VERDE;
  elsif rising_edge(clk) then
        current_state<=next_state; 
  end if;
 end process;
 nextstate_decod: process --(PUSHBUTTON, SENSOR, current_state)
 begin
 next_state <= current_state;
 case current_state is
 when VERDE =>
 if PUSHBUTTON = '1' then
 wait for t_prudencial;
 next_state <= AMBAR;
 end if;
 when AMBAR =>
wait for t_ambar;
 next_state <= ROJO;
 when ROJO =>
 wait for t_rojo;
 next_state <= VERDE;
 when others =>
 next_state <= ROJO;
 end case;
 end process;
 output_decod: process (current_state)
 begin
 SEM_COCH <= (OTHERS => '0');
 case current_state is
 when ROJO =>
 SEM_COCH(0) <= '1';
 when AMBAR =>
 SEM_COCH(1) <= '1';
 when VERDE =>
 SEM_COCH(2) <= '1';
 when others =>
 SEM_COCH <= (OTHERS => '0');
 end case;
 end process;
 
 semaforo_rojo: process (current_state) 
 begin 
 case (current_state) is 
 when ROJO =>
 SEM_ROJO <= '1';
 when others =>
 SEM_ROJO <= '0';
 end case; 
 end process;
 
end behavioral;
