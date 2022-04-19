----------------------------------------------------------------------------------
-- Arithmetic Shift Right Out = (int) A >> 1, {?[31], ?[31], ... ?[1]} 
-- Engineer: 
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

entity Arithmetic_Shift_Right is
    Port ( a_asr :      in  STD_LOGIC_VECTOR (31 downto 0);
           output_asr : out STD_LOGIC_VECTOR (31 downto 0));
end Arithmetic_Shift_Right;

architecture Behavioral of Arithmetic_Shift_Right is

begin
    
    -- &  :  concatenation,   array or element & array or element, result array
    output_asr <= a_asr(31) & a_asr(31 downto 1);
    
end Behavioral;
