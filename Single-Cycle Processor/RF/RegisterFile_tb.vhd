----------------------------------------------------------------------------------
-- Register File Testbench. 
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

entity RegisterFile_tb is
--  Port ( );
end RegisterFile_tb;

architecture Behavioral_RF_tb of RegisterFile_tb is

component RegisterFile
      Port ( Clk :   in  STD_LOGIC;
             Rst :   in  STD_LOGIC;
             Ard1 :  in  STD_LOGIC_VECTOR (4  downto 0);
             Ard2 :  in  STD_LOGIC_VECTOR (4  downto 0);
             Awr :   in  STD_LOGIC_VECTOR (4  downto 0);
             Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
             Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
             Din :   in  STD_LOGIC_VECTOR (31 downto 0);
             WrEn :  in  STD_LOGIC);
  end component;

  -- input signals
  signal Clk:   STD_LOGIC := '0';
  signal Rst:   STD_LOGIC := '0';
  signal Ard1:  STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
  signal Ard2:  STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
  signal Awr:   STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
  signal Din:   STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
  signal WrEn:  STD_LOGIC := '0';
  
  -- output signals 
  signal Dout1: STD_LOGIC_VECTOR (31 downto 0);
  signal Dout2: STD_LOGIC_VECTOR (31 downto 0);
  
  constant clock_period: time := 100 ns;

begin

  uut: RegisterFile port map ( Ard1  => Ard1,
                               Ard2  => Ard2,
                               Awr   => Awr,
                               Dout1 => Dout1,
                               Dout2 => Dout2,
                               Din   => Din,
                               WrEn  => WrEn,
                               Clk   => Clk,
                               Rst   => Rst );

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
  
    Rst <= '1'; -- hold reset
    wait for clock_period;
    
    Rst <= '0'; -- disable reset 
    
    -- Write Register 0 
    WrEn <= '1'; -- enable
    
    Ard1 <= "00000"; -- address 1
    Ard2 <= "00000"; -- address 2
    Awr  <= "00000"; -- address for writing
    
    Din  <= X"00001111"; -- Data for writing
    wait for clock_period; -- Register 0 IS ALWAYS 0 
    
    WrEn  <= '0';
    wait for clock_period;
    
    -- Try writing on more registers
    -- Write Register 1 
    WrEn <= '1'; -- enable
    
    Ard1 <= "00001"; -- address 1
    Ard2 <= "00001"; -- address 2
    Awr  <= "00001"; -- address for writing
    
    Din  <= X"11100111"; -- Data for writing
    wait for 2*clock_period;
    
    -- Write Register 31 
    WrEn <= '1'; -- enable
    
    Ard1 <= "11111"; -- address 1
    Ard2 <= "11111"; -- address 2
    Awr  <= "11111"; -- address for writing
    
    Din  <= X"11111111"; -- Data for writing
    wait for 2*clock_period;
    
    -- Read only
    WrEn <= '0';
    Ard1 <= "00001"; -- address 1
    Ard2 <= "00001"; -- address 2
    wait for clock_period;
 
    WrEn <= '0';
    wait for clock_period;
    
    WrEn <= '1';
    Ard1 <= "11100";
    Ard2 <= "00000";
    Awr  <= "11100"; -- address for writing
    
    Din  <= X"00111111"; -- Data for writing
    wait for clock_period;
    
    wait;
  end process;


end Behavioral_RF_tb;
