----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2020 22:44:19
-- Design Name: 
-- Module Name: Game_Objects - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Game_Objects is
    generic (
             RED         : STD_LOGIC_VECTOR (3 downto 0) := "0000";
             BLUE        : STD_LOGIC_VECTOR (3 downto 0) := "0000";
             GREEN       : STD_LOGIC_VECTOR (3 downto 0) := "1111";
             LEFT_POS_X  : NATURAL := 0;
             RIGHT_POS_X : NATURAL := 10;
             HIGH_Y      : NATURAL := 0;
             LOW_Y       : NATURAL := 10);
    port (
            X, Y    : in  UNSIGNED (10 downto 0);
            R,G,B   : out STD_LOGIC_VECTOR (3 downto 0);
            MASK    : out STD_LOGIC); --mask is when it will be drawing the shape
    
end Game_Objects;

architecture Behavioral of Game_Objects is
    signal FLAG : STD_LOGIC;
begin
    FLAG <='1' when (X >= LEFT_POS_X) and (X < RIGHT_POS_X)and(Y >= HIGH_Y) and (Y < LOW_Y) else '0'; --flag goes high when the rectangle is being drawn 

    R <= RED   when FLAG = '1' else (others => '0');
    B <= BLUE  when FLAG = '1' else (others => '0');
    G <= GREEN when FLAG = '1' else (others => '0');
    MASK <= FLAG;
end Behavioral;