----------------------------------------------------------------------------------
--  Shift Right Logican Operation : Out = (unsigned int) A >> 1 = {0, ?[31], ... ?[1]}
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

entity Shift_Right_Logical is
    Port ( a_srl : in STD_LOGIC_VECTOR (31 downto 0);
           output_srl : out STD_LOGIC_VECTOR (31 downto 0));
end Shift_Right_Logical;

architecture Behavioral_ShiftRightLogical of Shift_Right_Logical is

begin
    
    output_srl(31) <= '0';  
    output_srl(30 downto 0) <= a_srl(31 downto 1);  

end Behavioral_ShiftRightLogical;
