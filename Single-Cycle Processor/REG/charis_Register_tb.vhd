----------------------------------------------------------------------------------
-- Register Testbench.
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

entity charis_Register_tb is
--  empty entity
end charis_Register_tb;

architecture Behavioral_charis_Register_tb of charis_Register_tb is


  component charis_Register
      Port ( CLK :     in  STD_LOGIC;
             RST :     in  STD_LOGIC;
             WE :      in  STD_LOGIC;
             DataIn :  in  STD_LOGIC_VECTOR (31 downto 0);
             DataOut : out STD_LOGIC_VECTOR (31 downto 0));
  end component;

  signal CLK: STD_LOGIC;
  signal RST: STD_LOGIC;
  signal WE: STD_LOGIC;
  signal DataIn: STD_LOGIC_VECTOR (31 downto 0);
  signal DataOut: STD_LOGIC_VECTOR (31 downto 0);

  constant clock_period: time := 100 ns;

begin

  uut: charis_Register port map ( CLK     => CLK,
                                  RST     => RST,
                                  WE      => WE,
                                  DataIn  => DataIn,
                                  DataOut => DataOut );
                                  
  -- clock process                                
  clock: process
    begin
	   Clk <= '0';
	   wait for clock_period/2;
	   Clk <= '1';
	   wait for clock_period/2;
  end process;

  stimulus: process
    begin
    
        RST <= '1'; -- activate reset
        wait for clock_period; -- hold reset 
        
        RST <= '0'; -- deactivate reset
        WE  <= '0'; -- write enable is deactivated so we can't write anything
        
        DataIn <= X"00000000";
        wait for clock_period;
        
        WE <= '1'; -- activating write enable
        
        DataIn <= X"0000000f";
        wait for clock_period; 
        
        DataIn <= X"0000ffff";
        wait for clock_period;
        
        DataIn <= X"00008970";
        wait for clock_period;
        
        DataIn <= X"68f00ff0";
        wait for clock_period;
        
        RST <= '1'; -- activate reset
        
    --wait;
  end process;
  
  
end Behavioral_charis_Register_tb;
