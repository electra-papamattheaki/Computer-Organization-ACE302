----------------------------------------------------------------------------------
-- Circular Shift Left (Rotation) 
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

entity Circular_Shift_Left is
    Port ( a_csl : in STD_LOGIC_VECTOR (31 downto 0);
           output_csl : out STD_LOGIC_VECTOR (31 downto 0));
end Circular_Shift_Left;

architecture Behavioral_CSL of Circular_Shift_Left is

begin

    output_csl(0) <= a_csl(31);
    output_csl(31 downto 1) <= a_csl(30 downto 0);

end Behavioral_CSL;
