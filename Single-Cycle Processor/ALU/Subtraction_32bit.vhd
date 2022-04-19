----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2021 03:54:40 PM
-- Design Name: 
-- Module Name: Subtraction_32bit - Behavioral_Subtraction_32bit
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_BIT;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Subtraction_32bit is
    Port ( a_sub :      in  STD_LOGIC_VECTOR (31 downto 0);
           b_sub :      in  STD_LOGIC_VECTOR (31 downto 0);
           output_sub : out STD_LOGIC_VECTOR (31 downto 0);
           cout_sub :   out STD_LOGIC;
           ovf_sub :    out STD_LOGIC);
end Subtraction_32bit;

architecture Behavioral_Subtraction_32bit of Subtraction_32bit is

signal a_temp   :    std_logic_vector (32 downto 0);
signal b_temp   :    std_logic_vector (32 downto 0);
signal output_temp : std_logic_vector (32 downto 0);

begin

 a_temp(32)<='0' ;
 b_temp(32)<='0' ;

 a_temp(31 downto 0) <= a_sub(31 downto 0 );
 b_temp(31 downto 0) <= b_sub(31 downto 0 );

 output_temp <= a_temp - b_temp;    

 output_sub <= output_temp(31 downto 0);
 cout_sub   <= output_temp(32);
 
  -- ' /= ' : test for inequality, result is boolean
  -- If the sum of two positive numbers yields a negative result, the sum has overflowed.
  -- If the sum of two negative numbers yields a positive result, the sum has overflowed.
  -- So.... A(31) and B(31) need to be unequal because we are subtracting them not adding them.
 ovf_sub <= '1' when a_temp(31) /= b_temp(31) and a_temp(31) /= output_temp(31)
 else '0';
 
end Behavioral_Subtraction_32bit;
