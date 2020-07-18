----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2020 21:30:13
-- Design Name: 
-- Module Name: Basketball_Hoop - Behavioral
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

entity Basketball_Hoop is
  Port ( 
        X, Y : in UNSIGNED (10 downto 0);
        RGB : out STD_LOGIC_VECTOR (11 downto 0);
        MASK : out STD_LOGIC
);
end Basketball_Hoop;

architecture Behavioral of Basketball_Hoop is

begin

    FLAG <= '1' when (X >= 300) and (X < 370)
                and  (Y >= 300) and (Y < 370) else '0';
    RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
    MASK <= FLAG;

end Behavioral;
