----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 19:21:24
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

ENTITY top_tb IS
END top_tb;

architecture behavior of top_tb is 
    -- Declaramos las señales que se corresponden con las entradas y salidas de la entidad top
    signal rst_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';
    signal boton_tb: std_logic := '0';
    signal sensor_tb: std_logic := '0';
    signal rgb_peaton_tb: std_logic_vector(2 downto 0);
    signal rgb_coche_tb: std_logic_vector(2 downto 0);

    -- Instanciamos la entidad top
    component top is
        PORT (
            RESET_TOP: IN std_logic;
            CLK_TOP: IN std_logic;
            BOTON: IN std_logic;
            SNS: IN std_logic;
            RGB_PEATON: OUT std_logic_vector(2 downto 0);
            RGB_COCHE: OUT std_logic_vector(2 downto 0)
        );
    end component;
    
constant k : time := 10 ns;

begin
    -- Mapeamos las señales de prueba a la entidad top
    uut: top port map (
        RESET_TOP => rst_tb,
        CLK_TOP => clk_tb,
        BOTON => boton_tb,
        SNS => sensor_tb,
        RGB_PEATON => rgb_peaton_tb,
        RGB_COCHE => rgb_coche_tb
    );
    
    clk_tb <= not clk_tb after 0.5 * k;
    rst_tb <= '0', '1' after k;
    boton_tb <= '0', '1' after 4*k;

    -- Aquí es donde definirías tus estímulos de prueba
    stimulus: process
    begin
        --wait for k;
        --boton_tb <= '1';
        --wait for k/2;
        --boton_tb <= '0';
        wait for k*100;
        assert false report "Simulation complete" severity failure;
    end process;

end behavior;
