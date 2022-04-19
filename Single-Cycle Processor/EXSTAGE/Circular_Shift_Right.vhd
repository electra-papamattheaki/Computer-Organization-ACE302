----------------------------------------------------------------------------------
-- Circular Shift Right
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

entity Circular_Shift_Right is
    Port ( a_csr : in STD_LOGIC_VECTOR (31 downto 0);
           output_csr : out STD_LOGIC_VECTOR (31 downto 0));
end Circular_Shift_Right;

architecture Behavioral_CSR of Circular_Shift_Right is

begin

    output_csr(31) <= a_csr(0);
    output_csr(30 downto 0) <= a_csr(31 downto 1);

end Behavioral_CSR;
