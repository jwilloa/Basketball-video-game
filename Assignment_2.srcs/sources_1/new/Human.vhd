-----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2020 16:23:00
-- Design Name: 
-- Module Name: Human - Behavioral
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
use IEEE.numeric_std.all;

entity Human is
  Port ( 
        X, Y : in UNSIGNED (10 downto 0);
        RGB : out STD_LOGIC_VECTOR (11 downto 0);
        MASK : out STD_LOGIC);
end Human;

architecture Behavioral of Human is

signal FLAG : STD_LOGIC;

begin

    FLAG <= '1' when (X >= 15) and (X < 70)
                and  (Y >= 300) and (Y < 370) else '0';
    RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
    MASK <= FLAG;

end Behavioral;
