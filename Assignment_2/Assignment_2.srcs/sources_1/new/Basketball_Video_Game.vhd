----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2020 16:29:58
-- Design Name: 
-- Module Name: Basketball_Video_Game - Behavioral
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

entity Basketball_Video_Game is
    Port ( clk      : in  STD_LOGIC;
           Hsync    : out STD_LOGIC;
           Vsync    : out STD_LOGIC;
           vgaRed   : out STD_LOGIC_VECTOR(3 downto 0);
           vgaBlue  : out STD_LOGIC_VECTOR(3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
           vgaOut   : out STD_LOGIC_VECTOR (11 downto 0));
end Basketball_Video_Game;

architecture Behavioral of Basketball_Video_Game is


SIGNAL pixel_clk_line : STD_LOGIC;
SIGNAL Blank_Sig      : STD_LOGIC;
SIGNAL H_Sig, V_Sig   : UNSIGNED(10 downto 0);
SIGNAL Human_Mask, BasketRing_Mask, BasketTop_Mask, BasketBase_Mask, ball_flag : STD_LOGIC := '0';--, objectMask  : STD_LOGIC := '0'; -- signal for mask 

SIGNAL Human_R_Sig,  Human_B_Sig,  Human_G_Sig  : STD_LOGIC_VECTOR (3 downto 0); -- Human

SIGNAL BasketRing_R_Sig, BasketRing_B_Sig, BasketRing_G_Sig : STD_LOGIC_VECTOR (3 downto 0); -- Hoop ring
SIGNAL BasketTop_R_Sig,  BasketTop_B_Sig,  BasketTop_G_Sig  : STD_LOGIC_VECTOR (3 downto 0); -- Hoop top
SIGNAL BasketBase_R_Sig, BasketBase_B_Sig, BasketBase_G_Sig : STD_LOGIC_VECTOR (3 downto 0); -- Hoop base
SIGNAL BallR, BallB, BallG : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL objectRed,    objectGreen,  objectBlue   : STD_LOGIC_VECTOR (3 downto 0);

SIGNAL objectMask : STD_LOGIC;

begin

    Pixel_Clock : ENTITY work.Pixel_Clock(Behavioral) GENERIC MAP(modulo => 4)
    PORT MAP (
                clk => clk,
                pixel_clock => pixel_clk_line);

    VGA_Controller : ENTITY work.vga_controller_640_60(Behavioral)
    PORT MAP (
                rst         => '0',
                pixel_clk   => pixel_clk_line,
                HS          => Hsync,
                VS          => Vsync,
                hcount      => H_Sig,
                vcount      => V_Sig,
                blank       => Blank_Sig);       
   
   Human : ENTITY work.Game_Objects(Behavioral) 
   GENERIC MAP( 
            RED         => "1010", --0000
            BLUE        => "1010", --1111
            GREEN       => "1010", --0000
            LEFT_POS_X  => 510, --510
            RIGHT_POS_X => 520, --520
            HIGH_Y      => 390, --390
            LOW_Y       => 450) --450
    port map( 
            X => H_Sig,
            Y => V_Sig,
            R => Human_R_Sig,
            G => Human_G_Sig,       
            B => Human_B_Sig,
            MASK => Human_Mask);

   BasketBall_Ring : ENTITY work.Game_Objects(Behavioral) 
   GENERIC MAP( 
            RED         => "1010",
            BLUE        => "1010",
            GREEN       => "1010",
            LEFT_POS_X  => 10, --10
            RIGHT_POS_X => 50, --50
            HIGH_Y      => 190, --390
            LOW_Y       => 195) --395
    port map( 
            X => H_Sig,
            Y => V_Sig,
            R => BasketRing_R_Sig,
            G => BasketRing_G_Sig,       
            B => BasketRing_B_Sig,
            MASK => BasketRing_Mask);

   BasketBall_Top : ENTITY work.Game_Objects(Behavioral) 
   GENERIC MAP( 
            RED         => "1010",
            BLUE        => "1010",
            GREEN       => "1010",
            LEFT_POS_X  => 13, --15
            RIGHT_POS_X => 47, --44
            HIGH_Y      => 195, --405
            LOW_Y       => 205) --420
    port map( 
            X => H_Sig,
            Y => V_Sig,
            R => BasketTop_R_Sig,
            G => BasketTop_G_Sig,       
            B => BasketTop_B_Sig,
            MASK => BasketTop_Mask);

   BasketBall_Base: ENTITY work.Game_Objects(Behavioral) 
   GENERIC MAP( 
            RED         => "1010",
            BLUE        => "1010",
            GREEN       => "1010", --1111
            LEFT_POS_X  => 15, 
            RIGHT_POS_X => 44, 
            HIGH_Y      => 205,
            LOW_Y       => 220) 
    port map( 
            X => H_Sig,
            Y => V_Sig,
            R => BasketBase_R_Sig,
            G => BasketBase_G_Sig,       
            B => BasketBase_B_Sig,
            MASK => BasketBase_Mask);

    Basketball : ENTITY work.disc(Behavioral)
    port map (  
            PIXEL_CK => pixel_clk_line,
            X => H_Sig,
            Y => V_Sig,
            R => ballR,
            B => ballB,
            G => ballG,
            MASK => ball_flag);

               
                         
   objectRed   <= Human_R_Sig or BasketRing_R_Sig or BasketTop_R_Sig or BasketBase_R_Sig or ballR; --or Basket_R_Sig;             
   objectGreen <= Human_G_Sig or BasketRing_G_Sig or BasketTop_G_Sig or BasketBase_G_Sig or ballB; --or Basket_G_Sig;
   objectBlue  <= Human_B_Sig or BasketRing_B_Sig or BasketTop_B_Sig or BasketBase_B_Sig or ballG; --or Basket_B_Sig;      
   vgaRed      <= objectRed; --when objectMask = '1';-- else ballR;--BasketballRed;
   vgaGreen    <= objectGreen; --when objectMask = '1';-- else ballG;--BasketballGreen; 
   vgaBlue     <= objectBlue; --when objectMask = '1';-- else ballB;--BasketballBlue;
    
end Behavioral;