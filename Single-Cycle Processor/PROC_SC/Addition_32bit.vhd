----------------------------------------------------------------------------------
-- 32 bit Addition 
-- Engineer: Ilektra-Despoina Papamatthaiaki (2018030106)
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

entity Addition_32bit is
    Port ( a_add :      in  STD_LOGIC_VECTOR (31 downto 0);
           b_add :      in  STD_LOGIC_VECTOR (31 downto 0);
           output_add : out STD_LOGIC_VECTOR (31 downto 0);
           cout_add :   out STD_LOGIC;
           ovf_add :    out STD_LOGIC
          );
end Addition_32bit;

architecture Behavioral_Addition_32bit of Addition_32bit is

signal a_temp   :    std_logic_vector (32 downto 0);
signal b_temp   :    std_logic_vector (32 downto 0);
signal output_temp : std_logic_vector (32 downto 0);

begin

 a_temp(32)<='0' ;
 b_temp(32)<='0' ;

 a_temp(31 downto 0) <= a_add(31 downto 0 );
 b_temp(31 downto 0) <= b_add(31 downto 0 );

 output_temp <= a_temp + b_temp;    

 output_add <= output_temp(31 downto 0);
 cout_add <= output_temp(32);

 -- ' /= ' : test for inequality, result is boolean
 -- If the sum of two positive numbers yields a negative result, the sum has overflowed.
 -- If the sum of two negative numbers yields a positive result, the sum has overflowed.
 ovf_add <= '1' when a_temp(31) = b_temp(31) and a_temp(31) /= output_temp(31)
 else '0'; 

end Behavioral_Addition_32bit;
