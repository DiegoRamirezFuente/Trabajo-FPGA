library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_rgb is
port (
    CLK_RGB : in std_logic;
    RESET_RGB:in std_logic;
    sel_rgb: in std_logic_vector(5 downto 0);
    RGB_COCHES_RGB : out std_logic_vector (2 downto 0);
    RGB_PEAT_RGB : out std_logic_vector (2 downto 0)
);
end top_rgb;


architecture Behavioral of top_rgb is
COMPONENT decoder_rgb is
port (
    sel: in std_logic_vector(5 downto 0);
    RGB_COCHES : out std_logic_vector (2 downto 0);
    RGB_PEAT : out std_logic_vector (2 downto 0)
);
END COMPONENT;

COMPONENT control_rgb is
port (
    CLK : in std_logic;
    RESET:in std_logic;
    RGB_IN : in std_logic_vector (2 downto 0);
    RGB_OUT : out std_logic_vector (2 downto 0)
);
END COMPONENT;

COMPONENT cambio_intensidad is
port (
    CLK : in std_logic;
    RESET:in std_logic;
    ENTRADA : in std_logic_vector (2 downto 0);
    SALIDA : out std_logic_vector (2 downto 0)
);
END COMPONENT;

signal sig_rgb_coches : std_logic_vector (2 downto 0);
signal sig_rgb_peat,sig_rgb_peat_out : std_logic_vector (2 downto 0);
signal sig_rgb_coches_out_reg_int,sig_rgb_peat_out_reg_int : std_logic_vector (2 downto 0);

begin
    decoder_inst : decoder_rgb
    port map (
        sel => sel_rgb,
        RGB_COCHES => sig_rgb_coches,
        RGB_PEAT => sig_rgb_peat
    );
    
    peatones_control_inst : control_rgb
    port map (
        CLK => CLK_RGB,
        RESET => '1',--RESET_TOP,
        RGB_IN => sig_rgb_peat,
        RGB_OUT => sig_rgb_peat_out
    );
    
    regu_intensidad_coches : cambio_intensidad
    port map (
        CLK => CLK_RGB,
        RESET => '1',--RESET_TOP,
        ENTRADA => sig_rgb_coches,
        SALIDA => sig_rgb_coches_out_reg_int
    );
    
    regu_intensidad_peatones : cambio_intensidad
    port map (
        CLK => CLK_RGB,
        RESET => '1',--RESET_TOP,
        ENTRADA => sig_rgb_peat_out,
        SALIDA => sig_rgb_peat_out_reg_int
    );
    
    RGB_COCHES_RGB <= sig_rgb_coches_out_reg_int;
    RGB_PEAT_RGB <= sig_rgb_peat_out_reg_int;
    
end Behavioral;