----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2020 15:56:09
-- Design Name: 
-- Module Name: Pixel_Clock - Behavioral
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

entity Pixel_Clock is
    generic(
            modulo : NATURAL := 4);
    Port ( 
            clk           : in  STD_LOGIC; -- The clock input from the board 
            pixel_clock   : out STD_LOGIC);--The pixel clock ( the output of frequency divider )
end Pixel_Clock;

architecture Behavioral of Pixel_Clock is

signal div : STD_LOGIC ;

begin

process 
variable count : INTEGER; 

begin 

wait until RISING_EDGE(clk);
--Once the count has been reached the counter will reset and a ouptut high logic
    if count = (modulo - 1) then 
        count := 0;
        div <= '1'; 
    else
        count := count + 1;-- increment counter 
        div <= '0';--output low logic 
    end if;
    
end process ;
 
 pixel_clock <= div;

end Behavioral;