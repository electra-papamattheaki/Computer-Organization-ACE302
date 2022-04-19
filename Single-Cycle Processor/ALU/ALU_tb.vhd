----------------------------------------------------------------------------------
-- Arithmetic Logic Unit Testbench.
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

entity ALU_tb is
--  empty entity;
end ALU_tb;

architecture Behavioral_ALU_tb of ALU_tb is

  component ALU
      Port ( A :      in  STD_LOGIC_VECTOR (31 downto 0);
             B :      in  STD_LOGIC_VECTOR (31 downto 0);
             Op :     in  STD_LOGIC_VECTOR (3 downto 0);
             Output : out STD_LOGIC_VECTOR (31 downto 0);
             Zero :   out STD_LOGIC;
             Cout :   out STD_LOGIC;
             Ovf :    out STD_LOGIC
           );
      end component;

  signal A:      STD_LOGIC_VECTOR (31 downto 0);
  signal B:      STD_LOGIC_VECTOR (31 downto 0);
  signal Op:     STD_LOGIC_VECTOR (3 downto 0);
  signal Output: STD_LOGIC_VECTOR (31 downto 0);
  signal Zero:   STD_LOGIC;
  signal Cout:   STD_LOGIC;
  signal Ovf:    STD_LOGIC ;

begin

  uut: ALU port map ( A      => A,
                      B      => B,
                      Op     => Op,
                      Output => Output,
                      Zero   => Zero,
                      Cout   => Cout,
                      Ovf    => Ovf );

  -- stimulus process
  stimulus: process
  begin
  
    A <= "11110000000000000000000000000000"; -- f0000000 (HEX)
    B <= "00000000000000000000000000000000"; -- 00000000 (HEX)
  
    -- Checking all operations first with two simple numbers
    Op <= "0000";   -- 0 | Addition
    -- Expected Output: 11110000000000000000000000000000 = f0000000 (HEX) 
    wait for 50ns;
    
    
    Op <= "0001";   -- 1 | Subtraction
    -- Expected Output: 11110000000000000000000000000000 = f0000000 (HEX) 
    wait for 50ns;
    
    Op <= "0010";   -- 2 | Logical AND
    wait for 50ns;
    
    Op <= "0011";   -- 3 | Logical OR 
    wait for 50ns;
    
    Op <= "0100";   -- 4 | NOT A
    wait for 50ns;
    
    Op <= "0101";   -- 5 | Logical NAND
    wait for 50ns;
      
    Op <= "0110";   -- 6 | Logical NOR
    wait for 50ns;
    
    Op <= "1000";   -- 8 | Arithmetic Shift Right
    wait for 50ns;
    
    Op <= "1001";   -- 9 | Shift Right Logical
    wait for 50ns;
    
    Op <= "1010";   -- 10 (A) | Shift Left Logical
    wait for 50ns;
          
    Op <= "1100";   -- 12 (C) | Circular Shift Left
    wait for 50ns;
    
    Op <= "1101";   -- 13 (D) | Circular Shift Right
    wait for 50ns;
    
    -- Checking Cout
    
     A <= X"ff000000";
     B <= X"fff0000f";    
    
     Op <= "0000"; 
     wait for 50ns;        
     
     Op <= "0001"; 
     wait for 50ns;
     
     -- Checking Ovf
     A <= X"B0F09870"; -- 10110000111100001001100001110000
     B <= X"BF009807"; -- 10111111000000001001100000000111
     
     Op <= "0000";     -- Addition
     wait for 50ns;
     
     A <= X"7F001FFF"; -- 01111111000000000001111111111111   
     B <= X"4070F227"; -- 01000000011100001111001000100111
     wait for 50ns;    
     
     A <= X"80000000"; -- 1000000000000000000000000000000   
     B <= X"20000000"; -- 0100000000000000000000000000000
     
     Op <= "0001";     -- Subtraction
     wait for 50ns;     
     
     -- Checking Zero flag
     A <= X"ffffffff";
     B <= X"ffffffff";
     wait for 50ns;
        
     wait;
  end process;
end Behavioral_ALU_tb;
