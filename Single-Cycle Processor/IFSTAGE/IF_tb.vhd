----------------------------------------------------------------------------------
-- Instruction Fetch Unit Testbench
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_tb is
--  Port ( );
end IF_tb;

architecture Behavioral_IF_tb of IF_tb is

  component IFSTAGE
      Port ( Clk :      in  STD_LOGIC;
             Reset :    in  STD_LOGIC;
             PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
             PC_sel :   in  STD_LOGIC;
             PC_LdEn :  in  STD_LOGIC;
             PC :       out STD_LOGIC_VECTOR (31 downto 0));
  end component;

  -- Input signals
  signal Clk:      STD_LOGIC := '0';
  signal Reset:    STD_LOGIC := '0';
  signal PC_Immed: STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
  signal PC_sel:   STD_LOGIC := '0';
  signal PC_LdEn:  STD_LOGIC := '0';
  
  -- Output signal
  signal PC:       STD_LOGIC_VECTOR (31 downto 0);
  
  constant clock_period: time := 100 ns;

begin

  uut: IFSTAGE port map ( Clk      => Clk,
                          Reset    => Reset,
                          PC_Immed => PC_Immed,
                          PC_sel   => PC_sel,
                          PC_LdEn  => PC_LdEn,
                          PC       => PC );

 -- Stimulus process
  stimulus: process
  begin
  
    Reset <= '1'; -- hold reset
    wait for clock_period;
    
    Reset <= '0'; -- disable reset
    
    PC_LdEn <= '1'; 
    PC_sel  <= '0'; -- PC+4
    PC_Immed <= std_logic_vector(to_unsigned(4,32));
    wait for clock_period;
    
    PC_LdEn <= '1'; 
    PC_sel  <= '0'; -- PC+4
    PC_Immed <= std_logic_vector(to_unsigned(8,32));
    wait for clock_period;

    PC_sel  <= '0'; -- PC+4+Immed
    PC_Immed <= std_logic_vector(to_unsigned(12,32));
    wait for clock_period;    
    
    PC_sel  <= '0'; -- PC+4+Immed
    PC_Immed <= std_logic_vector(to_unsigned(16,32));
    wait for clock_period;   
    
    PC_LdEn <= '0'; 
    PC_sel  <= '0'; -- PC+4
    PC_Immed <= std_logic_vector(to_unsigned(20,32));
    wait for clock_period;
    
    PC_LdEn <= '1'; 
    PC_sel  <= '1'; -- PC+4+Immed
    PC_Immed <= std_logic_vector(to_unsigned(24,32));
    wait for clock_period;

    PC_LdEn <= '1'; 
    PC_sel  <= '0'; -- PC+4
    PC_Immed <= std_logic_vector(to_unsigned(28,32));
    wait for clock_period;

wait;
  end process; 
  
 -- Clocking Process 
 clocking: process
   begin
	   Clk <= '0';
	   wait for clock_period/2;
	   Clk <= '1';
	   wait for clock_period/2;
  end process;

end Behavioral_IF_tb;
