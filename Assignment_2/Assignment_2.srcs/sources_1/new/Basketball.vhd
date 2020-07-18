------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 20.02.2020 15:44:35
---- Design Name: 
---- Module Name: Basketball - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disc is
    generic (
            CX    : NATURAL                       := 100;
            CY    : NATURAL                       := 100;
            RP    : NATURAL                       := 20;
            RED   : STD_LOGIC_VECTOR (3 downto 0) := "1111";
            BLUE  : STD_LOGIC_VECTOR (3 downto 0) := "0000";
            GREEN : STD_LOGIC_VECTOR (3 downto 0) := "0000");
port (
    PIXEL_CK : in  STD_LOGIC;
    X, Y     : in  UNSIGNED         (10 downto 0);
    R,G,B    : out STD_LOGIC_VECTOR (3 downto 0);
    MASK     : out STD_LOGIC );
end disc;

architecture Behavioral of disc is

signal DX, DY   : UNSIGNED (X'range);
signal DX2, DY2 : UNSIGNED ((2*X'high+1) downto 0);
signal FLAG     : STD_LOGIC;
constant R2     : UNSIGNED (DX2'range) := to_unsigned(RP * RP, DX2'length);

begin
    DX <= X - CX when X > CX else CX - X;
    DY <= Y - CY when Y > CY else CY - Y;
    DX2 <= DX * DX;
    DY2 <= DY * DY;
    FLAG <= '1' when (DX2 + DY2 < R2) else '0';

    R <= RED   when FLAG = '1' else (others => '0');
    B <= BLUE  when FLAG = '1' else (others => '0');
    G <= GREEN when FLAG = '1' else (others => '0');
    MASK <= FLAG;
end Behavioral;