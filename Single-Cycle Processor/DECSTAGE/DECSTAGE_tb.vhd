----------------------------------------------------------------------------------
-- DECSTAGE Testbench.
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

entity DECSTAGE_tb is
--  Port ( );
end DECSTAGE_tb;

architecture Behavioral_tb of DECSTAGE_tb is

  component DECSTAGE
      Port ( Clk :           in  STD_LOGIC;
             Rst :           in  STD_LOGIC;
             Instr :         in  STD_LOGIC_VECTOR (31 downto 0);
             RF_WrEn :       in  STD_LOGIC;
             ALU_out :       in  STD_LOGIC_VECTOR (31 downto 0);
             MEM_out :       in  STD_LOGIC_VECTOR (31 downto 0);
             RF_WrData_sel : in  STD_LOGIC;
             RF_B_sel :      in  STD_LOGIC;
             ImmExt :        in  STD_LOGIC_VECTOR (1 downto 0);
             Immed :         out STD_LOGIC_VECTOR (31 downto 0);
             RF_A :          out STD_LOGIC_VECTOR (31 downto 0);
             RF_B :          out STD_LOGIC_VECTOR (31 downto 0));
  end component;

  -- Input signals
  signal Clk:           STD_LOGIC := '0';
  signal Rst:           STD_LOGIC := '0';
  signal Instr:         STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  signal RF_WrEn:       STD_LOGIC := '0';
  signal ALU_out:       STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  signal MEM_out:       STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  signal RF_WrData_sel: STD_LOGIC := '0';
  signal RF_B_sel:      STD_LOGIC := '0';
  signal ImmExt:        STD_LOGIC_VECTOR (1 downto 0) := "00";
  
  -- Output signals
  signal Immed:         STD_LOGIC_VECTOR (31 downto 0);
  signal RF_A:          STD_LOGIC_VECTOR (31 downto 0);
  signal RF_B:          STD_LOGIC_VECTOR (31 downto 0);

  constant clock_period: time := 100 ns;
  
begin

  uut: DECSTAGE port map ( Clk           => Clk,
                           Rst           => Rst,
                           Instr         => Instr,
                           RF_WrEn       => RF_WrEn,
                           ALU_out       => ALU_out,
                           MEM_out       => MEM_out,
                           RF_WrData_sel => RF_WrData_sel,
                           RF_B_sel      => RF_B_sel,
                           ImmExt        => ImmExt,
                           Immed         => Immed,
                           RF_A          => RF_A,
                           RF_B          => RF_B );

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
  
        Rst <= '1'; -- hold reset for 100ns
        wait for clock_period; 

        Rst <= '0'; -- enable reset
        
        Instr(31 downto 26) <= "000000"; -- no processing required
        -- Write Register 1
        Instr(25 downto 21) <= "00000"; -- Read Register1
        Instr(20 downto 16) <= "00001"; -- Write Register / Mux in 1
		Instr(15 downto 11) <= "00010"; -- Mux In 0
		 
		RF_WrEn  <= '1'; -- enable
		RF_B_sel <= '1'; -- disabled	
		RF_WrData_sel <= '0'; 
			
		Instr(15 downto 0) <= "1111111111100010";
        wait for clock_period;
        
        ALU_out <= std_logic_vector(to_signed(256,32));
		MEM_out <= std_logic_vector(to_signed(301,32));
        
        -- Checking all ImmExt...
        -- ZeroExtend
        Instr(31 downto 26) <= "110010"; 
        ImmExt <= "00";
        wait for clock_period;

        -- <<16 ZeroFill
        Instr(31 downto 26) <= "111001"; 
        ImmExt <= "01";
        wait for clock_period;        
        
        -- SignExtend
        Instr(31 downto 26) <= "111000"; 
        ImmExt <= "10";
        wait for clock_period;

        Instr(31 downto 26) <= "000111"; 
        ImmExt <= "10";
        wait for clock_period;   
        
        -- 2<<SignExtend
        Instr(31 downto 26) <= "000011"; 
        ImmExt <= "11";
        wait for clock_period;   
        
        Instr(31 downto 26) <= "111111";
        Instr(25 downto 21) <= "00001";
		Instr(20 downto 16) <= "00010";
		Instr(15 downto 0)  <= std_logic_vector(to_signed(1024,16));
		
        RF_WrEn  <= '0'; -- enable
		RF_B_sel <= '1'; -- disabled   
		RF_WrData_sel <= '1'; 
		
		ALU_out <= std_logic_vector(to_signed(264,32));
		MEM_out <= std_logic_vector(to_signed(341,32));
		wait for clock_period;
		        
  wait;
  end process; 

end Behavioral_tb;
