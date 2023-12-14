library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquina_estados_tb is
end entity;

architecture behavioural of maquina_estados_tb is
    -- Import the entity to be tested
    component maquina_estados is
        port (
            RESET : in std_logic;
            CLK : in std_logic;
            PUSHBUTTON : in std_logic;
            SENSOR : in std_logic;
            SEM : out std_logic_vector(5 downto 0) -- (VC,AC,RC,VP,PP,RP)
        );
    end component;

    -- Declare signals for the testbench
    signal reset_sig : std_logic := '0';
    signal clk_sig : std_logic := '0';
    signal pushbutton_sig : std_logic := '0';
    signal sensor_sig : std_logic := '0';
    signal sem_sig : std_logic_vector(5 downto 0);
    
    constant k : time := 10 ns;
    
begin
    -- Instantiate the entity to be tested
    DUT : maquina_estados
        port map (
            RESET => reset_sig,
            CLK => clk_sig,
            PUSHBUTTON => pushbutton_sig,
            SENSOR => sensor_sig,
            SEM => sem_sig
        );
        
    clk_sig <= not clk_sig after 0.5 * k;
    reset_sig <= '0', '1' after 1.25*k;

    -- Stimulus process
    stimulus : process
    begin
        pushbutton_sig <= '0';
        wait for 10 ns;
        pushbutton_sig <= '1';
        wait for 10*k;

        assert false report "Simulation complete" severity failure;
    end process;

end architecture;