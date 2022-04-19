----------------------------------------------------------------------------------
-- Processor Signle Cycle Testbench.
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

entity PROC_SC_TB is
--  Port ( );
end PROC_SC_TB;

architecture Behavioral_PROC_SC_TB of PROC_SC_TB is

  component PROC_SC
      Port ( Clk :      in  STD_LOGIC;
             Reset :    in  STD_LOGIC);
  end component;

  signal Clk:   STD_LOGIC := '0';
  signal Reset: STD_LOGIC := '0';
  
  constant clock_period : time := 100 ns;

begin

  uut: PROC_SC port map ( Clk   => Clk,
                          Reset => Reset );
  
   -- Clock Process 
   clocking_process :process
   begin
		Clk <= '0';
		wait for clock_period/2;
		Clk <= '1';
		wait for clock_period/2;
   end process;

  -- Stimulus Process
  stimulus: process
  begin
  
    -- Put initialisation code here
    Reset <= '1';
    wait for clock_period*2;
    Reset <= '0';
    wait;

    -- Put test bench stimulus code here

    wait;
  end process;

end Behavioral_PROC_SC_TB;
