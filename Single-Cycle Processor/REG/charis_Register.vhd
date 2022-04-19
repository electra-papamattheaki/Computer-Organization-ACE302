----------------------------------------------------------------------------------
-- A Register Module.
-- Register gets it's output after 10ns
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

entity charis_Register is
    Port ( CLK :     in  STD_LOGIC;
           RST :     in  STD_LOGIC;
           WE :      in  STD_LOGIC;
           DataIn :  in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end charis_Register;

architecture Behavioral_Register of charis_Register is

signal register_out_tmp : std_logic_vector (31 downto 0);

begin
    process
        begin
            wait until CLK'event and CLK = '1';
            --if rising_edge(CLK) then
                if RST = '1' then -- RST is active high
                    register_out_tmp <= (others => '0');
                else
                    if WE = '1' then -- if WE = '0' you cannot write
                        register_out_tmp <= DataIn;
                    end if;
                end if;
    end process;
    
    DataOut <= register_out_tmp after 10ns;

end Behavioral_Register;
