----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2021 10:57:46 PM
-- Design Name: 
-- Module Name: Mux2to1_5bit - Behavioral_Mux2to1
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2to1_5bit is
    Port ( mux_in0 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_in1 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_sel : in  STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR (4 downto 0));
end Mux2to1_5bit;

architecture Behavioral_Mux2to1 of Mux2to1_5bit is

begin

        mux_out <= mux_in0 when mux_sel = '0'
        else       mux_in1 when mux_sel = '1';

end Behavioral_Mux2to1;
