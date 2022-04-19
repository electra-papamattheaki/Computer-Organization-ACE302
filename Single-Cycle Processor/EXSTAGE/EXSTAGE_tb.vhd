----------------------------------------------------------------------------------
-- Execution Stage Testbench.
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

entity EXSTAGE_tb is
--  Port ( );
end EXSTAGE_tb;

architecture Behavioral_exstage_tb of EXSTAGE_tb is

  component EXSTAGE
      Port ( RF_A :        in  STD_LOGIC_VECTOR (31 downto 0);
             RF_B :        in  STD_LOGIC_VECTOR (31 downto 0);
             Immed :       in  STD_LOGIC_VECTOR (31 downto 0);
             ALU_Bin_sel : in  STD_LOGIC;
             ALU_func :    in  STD_LOGIC_VECTOR (3 downto 0);
             ALU_out :     out STD_LOGIC_VECTOR (31 downto 0);
             ALU_zero :    out STD_LOGIC;
             ALU_Cout :    out STD_LOGIC;
             ALU_Ovf :     out STD_LOGIC);
  end component;

  -- Input signals
  signal RF_A: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  signal RF_B: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  signal Immed: STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
  signal ALU_Bin_sel: STD_LOGIC := '0';
  signal ALU_func: STD_LOGIC_VECTOR (3 downto 0) := "0000";
  
  -- Output signals
  signal ALU_out: STD_LOGIC_VECTOR (31 downto 0);
  signal ALU_zero: STD_LOGIC ;
  signal ALU_Cout: STD_LOGIC;
  signal ALU_Ovf: STD_LOGIC;

begin

  uut: EXSTAGE port map ( RF_A        => RF_A,
                          RF_B        => RF_B,
                          Immed       => Immed,
                          ALU_Bin_sel => ALU_Bin_sel,
                          ALU_func    => ALU_func,
                          ALU_out     => ALU_out,
                          ALU_zero    => ALU_zero,
                          ALU_Cout    => ALU_Cout,
                          ALU_Ovf     => ALU_Ovf );

  stimulus: process
  begin
  
    wait for 100ns; -- hold
  
    ALU_Bin_sel <= '0'; -- A + B 
    -- Addition 
    ALU_func <= "0000";
    -- Testing ZeroFlag
    
    RF_A  <= X"00000000";
    RF_B  <= X"00000000";
    Immed <= X"00000000";
    wait for 100ns;
        
    -- Testing Ovf
    RF_A  <= X"80000000"; -- 100000000000000000000000000000000000
    RF_B  <= X"80000000"; -- 100000000000000000000000000000000000
    wait for 100ns;
    
    -- Testing Cout
    RF_A  <= X"C0000000"; -- 110000000000000000000000000000000000
    RF_B  <= X"40000000"; -- 010000000000000000000000000000000000
    wait for 100ns;  
    
    -- Subtraction
    ALU_func <= "0001";
    ALU_Bin_sel <= '1';  --  A - Immed
    
    RF_A  <= X"01111111";
    RF_B  <= X"50505050";
    Immed <= X"00000011";
    wait for 100ns; 
    
    RF_A  <= X"11111111";
    RF_B  <= X"01111111";
    Immed <= X"10000000";     
    wait for 100ns;
    
    RF_A  <= X"11111111";
    RF_B  <= X"01111111";
    Immed <= X"11111111";
    wait for 100ns;
    
    -- NAND
    ALU_func <= "0101";
    RF_A  <= X"11111111";
    wait for 100ns;
    
    -- Shift Right Logical
    ALU_func <= "1001";
    RF_A  <= X"80000001"; -- 10000000000000000000000000000001
    -- Expecting             01000000000000000000000000000000 (HEX: 40000000)
    wait for 100ns; 
    
    -- Circular Shift Left
    ALU_func <= "1100";   
    RF_A  <= X"C0000003"; -- 11000000000000000000000000000011
    -- Expectiong            10000000000000000000000000000111 (HEX: 80000007)
    
    wait;
  end process;


end Behavioral_exstage_tb;
