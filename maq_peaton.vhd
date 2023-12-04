----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2023 15:48:13
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

entity maq_peaton is
 port (
 RESET : in std_logic;
 CLK : in std_logic;
 ROJOCOCHE : in std_logic;
 SEM_PEAT : out std_logic_vector(2 downto 0)
 );
end maq_peaton;
architecture behavioral of maq_peaton is
 type STATES is (VERDE, ROJO , PARPADEO);
 signal current_state: STATES := ROJO;
 signal next_state: STATES;
 -- constant t_rojo : time := 10 ns;
 constant t_parpadeo : time := 20 ns;
 constant t_verde : time := 70 ns;
 constant t_prudencial : time := 10 ns;
 
begin
 state_register: process (RESET, CLK)
 begin
  if reset='0' then
  current_state<=ROJO;
  elsif rising_edge(clk) then
        current_state<=next_state;
  end if;
 end process;
 nextstate_decod: process --(ROJOCOCHE, current_state)
 begin
 next_state <= current_state;
 case current_state is
 when ROJO =>
 if ROJOCOCHE = '1' then
 wait for t_prudencial;
 next_state <= VERDE;
 end if;
 when VERDE =>
 wait for t_verde;
 next_state <= PARPADEO;
 when PARPADEO =>
 wait for t_parpadeo;
 next_state <= VERDE;
 when others =>
 next_state <= ROJO;
 end case;
 end process;
 output_decod: process (current_state)
 begin
 SEM_PEAT <= (OTHERS => '0');
 case current_state is
 when ROJO =>
 SEM_PEAT(0) <= '1';
 when VERDE =>
 SEM_PEAT(1) <= '1';
 when PARPADEO =>
 SEM_PEAT(2) <= '1';
 when others =>
 SEM_PEAT <= (OTHERS => '0');
 end case;
 end process;
end behavioral;
