----------------------------------------------------------------------------------
-- Shift Left Logical operation : Ou t= A << 1 = {?[30], ?[29],... ?[0],0} 
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

entity Shift_Left_Logical is
    Port ( a_sll : in STD_LOGIC_VECTOR (31 downto 0);
           output_sll : out STD_LOGIC_VECTOR (31 downto 0));
end Shift_Left_Logical;

architecture Behavioral of Shift_Left_Logical is

begin

    output_sll(0) <= '0';
    output_sll(31 downto 1) <= a_sll(30 downto  0);

end Behavioral;
