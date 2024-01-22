library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY top_display IS
 PORT ( 
 clk_disp:in std_logic;
 reset_disp:in std_logic;
 --code_disp : IN std_logic_vector(3 DOWNTO 0);
 --v_sel : IN std_logic_vector(3 DOWNTO 0);
 v_sal : OUT std_logic_vector(7 DOWNTO 0);
 segment : OUT std_logic_vector(6 DOWNTO 0);
 enable_disp: in std_logic;
 modo_buzz: in std_logic;
 buzz_disp: OUT std_logic
 );
END top_display;
architecture Behavioral of top_display is

COMPONENT decoder
PORT (
code : IN std_logic_vector(3 DOWNTO 0);
led : OUT std_logic_vector(6 DOWNTO 0)
);
END COMPONENT;

COMPONENT countdown
Port ( 
clk:in std_logic;
reset:in std_logic;
enable:in std_logic;
segundos: out unsigned(3 DOWNTO 0);
fin:out std_logic
);
end COMPONENT;

COMPONENT cambio_digsel is
    port (
        clk : in std_logic;
        enable_digsel: in std_logic;
        digsel : out std_logic_vector(7 downto 0);
        segment_uni_in:in std_logic_vector(6 downto 0);
        segment_dec_in:in std_logic_vector(6 downto 0);
        segment_out:out std_logic_vector(6 downto 0)
    );
    END COMPONENT;


COMPONENT buzz is
  port (
    modo:in std_logic;
    enable_buzz: in std_logic;
    clk : in std_logic;
    buzzer : out std_logic
  );
END COMPONENT;

signal count_uni: std_logic_vector(3 DOWNTO 0);
signal count_dec: std_logic_vector(3 DOWNTO 0);
signal fin_top: std_logic;
signal fin_dec: std_logic;
signal segment_uni_sig:std_logic_vector(6 downto 0);
signal segment_dec_sig: std_logic_vector(6 downto 0);
signal segment_sig: std_logic_vector(6 downto 0);
begin
    
    unidades: entity work.countdown 
generic map(cuenta=>1e9-1)
port map ( 
        clk => clk_disp,
        reset => reset_disp,
        enable => enable_disp,
        segundos => count_uni,
        fin => fin_top
    );
    
    decenas: entity work.countdown 
    generic map(cuenta=>2e8-1)
    port map ( 
        clk => clk_disp,
        reset => reset_disp,
        enable => fin_top,
        segundos => count_dec,
        fin => fin_dec
    );
    
    display_unidades: decoder port map(
    code => count_uni ,
    led => segment_uni_sig
    );

    display_decenas: decoder port map(
    code => count_dec ,
    led => segment_dec_sig
    );
    
    gestion_digsel: cambio_digsel
    port map (
        clk => clk_disp,
        enable_digsel => enable_disp,
        segment_uni_in => segment_uni_sig, 
        segment_dec_in => segment_dec_sig,
        digsel => v_sal,
        segment_out => segment_sig
    );
    
    buz:buzz
  port map (
    modo=> modo_buzz,
    enable_buzz => enable_disp,
    clk => clk_disp,
    buzzer => buzz_disp
  );
  
    segment<=segment_sig;
end Behavioral;