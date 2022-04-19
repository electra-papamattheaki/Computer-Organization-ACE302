----------------------------------------------------------------------------------
-- Incrementor used to generate PC+4. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Incrementor is
    Port ( incr_in :  in  STD_LOGIC_VECTOR (31 downto 0);
           incr_out : out STD_LOGIC_VECTOR (31 downto 0));
end Incrementor;

architecture Behavioral_Incrementor of Incrementor is

begin

    incr_out <= incr_in + 4; 

end Behavioral_Incrementor;
