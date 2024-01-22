library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cambio_intensidad is
port (
    CLK : in std_logic;
    RESET:in std_logic;
    ENTRADA : in std_logic_vector(2 downto 0);
    SALIDA : out std_logic_vector(2 downto 0)
);
end cambio_intensidad;

architecture Behavioral of cambio_intensidad is

signal count : integer range 0 to 44e4 := 0;--e
signal duty : integer := 41e4;---e
signal encendido : std_logic_vector(2 downto 0);
begin
 process (CLK, RESET)
    begin
        if RESET = '0' then
            count <= 0;
            encendido<="000";
        elsif rising_edge(clk) then
           if count>=44e4 then --e
            count<=0;
           else
            count <= count +1;
           end if;
            if count <= duty then
                encendido <= "000";
            elsif count > duty then 
                encendido <= ENTRADA;
            end if;
        end if;
    end process;
    
    SALIDA <= encendido;
           
end behavioral;

