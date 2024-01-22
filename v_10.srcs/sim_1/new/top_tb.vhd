library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end entity;

architecture behavioural of top_tb is
    -- Import the entity to be tested
    component top is
    port (
    RESET_TOP : in std_logic;
    CLK_TOP : in std_logic;
    BOTON_INICIO : in std_logic; -- START, interruptor siempre encendido para que funcione el programa
    BOTON_ESPERA : in  std_logic;
    SENSOR_TOP:in std_logic;
    
    RGB_COCHES_TOP: out std_logic_vector(2 downto 0);
    RGB_PEAT_TOP: out std_logic_vector(2 downto 0)
    --SEM_TOP : out std_logic_vector(5 downto 0)--(VC,AC,RC,VP,PP,RP)
    );
    end component;

    -- Declare signals for the testbench
    signal reset_sig : std_logic := '0';
    signal clk_sig : std_logic := '0';
    signal pushbutton_sig : std_logic := '0';
    signal pushbutton_espera_sig : std_logic := '0';
    signal sensor_sig : std_logic := '0';
    --signal sem_sig : std_logic_vector(5 downto 0);
    signal rgb_coches_sig,rgb_peat_sig : std_logic_vector(2 downto 0);
    
    constant k : time := 10 ns;
    
begin
    -- Instantiate the entity to be tested
    DUT : top port map (
            RESET_TOP => reset_sig,
            CLK_TOP => clk_sig,
            BOTON_INICIO=> pushbutton_sig,
            BOTON_ESPERA => pushbutton_espera_sig,
            SENSOR_TOP => sensor_sig,
            
            RGB_COCHES_TOP => rgb_coches_sig ,
            RGB_PEAT_TOP => rgb_peat_sig
            --SEM_TOP => sem_sig
        );
        
    clk_sig <= not clk_sig after 0.5*k;
    reset_sig <= '0', '1' after 1*k;
    
    pushbutton_espera_sig <='1' after 66*k,'0' after 67*k;

    -- Stimulus process
    stimulus : process
    begin
        pushbutton_sig <= '0';
        wait for k;
        pushbutton_sig <= '1';
        wait for 100*k;
--        for i in 1 to 4 loop
--        wait until rgb_coches_sig= "011";
--        end loop;

        assert false report "Simulation complete" severity failure;
    end process;

end architecture;