----------------------------------------------------------------------------------
-- A simple adder that computes (PC+4) + SignExt(Immed)*4, for branch instructions.
----------------------------------------------------------------------------------S

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder is
    Port ( adder_in0 : in  STD_LOGIC_VECTOR (31 downto 0);   -- 1st Input: PC + 4
           adder_in1 : in  STD_LOGIC_VECTOR (31 downto 0);   -- 2nd Input: PC_Immed
           adder_out : out STD_LOGIC_VECTOR (31 downto 0));  -- Output
end Adder;

architecture Behavioral_adder of Adder is

signal temp : std_logic_vector (31 downto 0);

begin

    adder_out <= adder_in0 + adder_in1; 

end Behavioral_adder;
