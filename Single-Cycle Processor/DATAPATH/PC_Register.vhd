----------------------------------------------------------------------------------
-- Program Counter Register.
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

entity PC_Register is
    Port ( Clk :     in  STD_LOGIC;                         -- Clock
           Reset :   in  STD_LOGIC;                         -- Reset
           PC_in :   in  STD_LOGIC_VECTOR (31 downto 0);    -- Input data 
           PC_LdEn : in  STD_LOGIC;                         -- Load Enable (instruction fetch)
           PC_out :  out STD_LOGIC_VECTOR (31 downto 0));   -- Output data
end PC_Register;

architecture Behavioral_PC of PC_Register is

-- temporary output
signal PC_outTemp : std_logic_vector (31 downto 0);

begin
--    process
--        begin
--            wait until Clk'event and Clk = '1';
--                if Reset = '1' then
--                    PC_outTemp <= X"00000000"; -- initial state
--                else
--                    if PC_LdEn = '1' then 
--                        PC_outTemp <= PC_in; 
--                    else
--                        PC_outTemp <= X"00000000"; -- initial state
--                    end if;
--                end if;
                
--        PC_out <= PC_outTemp after 10ns; 
--    end process;

process_reg: process(Clk,Reset,PC_outTemp)

    begin
        if Reset = '1' then
        
            PC_outTemp <= (others => '0');
            
        elsif  rising_edge(Clk) then
           
           if PC_LdEn = '1' then PC_outTemp <= PC_in;
           end if;
           
        end if;

    PC_out <= PC_outTemp after 10ns;

    end process process_reg;
      
end Behavioral_PC;
