----------------------------------------------------------------------------------
-- Datapath Testbench.
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

entity DATAPATH_TB is
--  Port ( );
end DATAPATH_TB;

architecture Behavioral_Datapath_Tb of DATAPATH_TB is

  component DATAPATH
      Port ( Clock :         in  STD_LOGIC;
             Rst :           in  STD_LOGIC;
             Instruction :   in  STD_LOGIC_VECTOR (31 downto 0);
             PC_sel :        in  STD_LOGIC;
             PC_LdEn :       in  STD_LOGIC;
             PC :            out STD_LOGIC_VECTOR (31 downto 0);
             RF_WrEn :       in  STD_LOGIC;
             RF_WrData_sel : in  STD_LOGIC;
             RF_B_sel :      in  STD_LOGIC;
             ImmExt :        in  STD_LOGIC_VECTOR (1 downto 0);
             ALU_Bin_sel :   in  STD_LOGIC;
             ALU_func :      in  STD_LOGIC_VECTOR (3 downto 0);
             ALU_Zero :      out STD_LOGIC;
             ByteOp :        in  STD_LOGIC;
             Mem_WrEn :      in  STD_LOGIC;
             MM_Addr :       out STD_LOGIC_VECTOR (31 downto 0);
             MM_WrEn :       out STD_LOGIC;
             MM_WrData :     out STD_LOGIC_VECTOR (31 downto 0);
             MM_RdData :     in  STD_LOGIC_VECTOR (31 downto 0));
  end component;

  signal Clock:         STD_LOGIC := '0';
  signal Rst:           STD_LOGIC := '0';
  signal Instruction:   STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  signal PC_sel:        STD_LOGIC := '0';
  signal PC_LdEn:       STD_LOGIC := '0';
  signal RF_WrEn:       STD_LOGIC := '0';
  signal RF_WrData_sel: STD_LOGIC := '0';
  signal RF_B_sel:      STD_LOGIC := '0';
  signal ImmExt:        STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
  signal ALU_Bin_sel:   STD_LOGIC := '0';
  signal ALU_func:      STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
  signal ByteOp:        STD_LOGIC := '0';
  signal Mem_WrEn:      STD_LOGIC := '0';
  signal MM_RdData:     STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
  
  -- Output Signals
  signal PC:            STD_LOGIC_VECTOR (31 downto 0);
  signal ALU_Zero:      STD_LOGIC;
  signal MM_Addr:       STD_LOGIC_VECTOR (31 downto 0);
  signal MM_WrEn:       STD_LOGIC;
  signal MM_WrData:     STD_LOGIC_VECTOR (31 downto 0);
  
  constant clock_period : time := 100 ns;

begin

  uut: DATAPATH port map ( Clock         => Clock,
                           Rst           => Rst,
                           Instruction   => Instruction,
                           PC_sel        => PC_sel,
                           PC_LdEn       => PC_LdEn,
                           PC            => PC,
                           RF_WrEn       => RF_WrEn,
                           RF_WrData_sel => RF_WrData_sel,
                           RF_B_sel      => RF_B_sel,
                           ImmExt        => ImmExt,
                           ALU_Bin_sel   => ALU_Bin_sel,
                           ALU_func      => ALU_func,
                           ALU_Zero      => ALU_Zero,
                           ByteOp        => ByteOp,
                           Mem_WrEn      => Mem_WrEn,
                           MM_Addr       => MM_Addr,
                           MM_WrEn       => MM_WrEn,
                           MM_WrData     => MM_WrData,
                           MM_RdData     => MM_RdData );

   Clocking_process : process
   begin
		Clock <= '0';
		wait for clock_period/2;
		Clock <= '1';
		wait for clock_period/2;
   end process;
   
  -- Stimulus process
 stim_proc: process
   begin
   		
      -- hold reset state for 100 ns.
		Rst <= '1';
		wait for clock_period;
		
		PC_sel  <= '0'; 		
		PC_LdEn <= '1'; 
		Rst     <= '0';
		wait for clock_period;
		
--		--addi r2,r0,3; -> 0011
--		RF_B_sel<='1'; 		   -- immediate ->rd in ard2
--		RF_WrData_sel<='0';     -- alu out
--		RF_WrEn<='1';
--		ALU_Bin_sel<='1'; 	    -- immediate 
--		ALU_func<="0000"; 	    -- add
--		Mem_WrEn<='0';
--		ByteOp<='0'; 			-- dont care
--		ImmExt<="01"; 			-- sign extend

        wait for clock_period;
	
		-- addi r5,r0,8
		PC_sel        <='0'; 
		PC_LdEn       <='1'; 
		RF_WrEn       <='1';
		RF_WrData_sel <='0';     -- Alu out 
		RF_B_sel      <='0';
		ImmExt        <= "10";   -- SIGN EXT
		ALU_Bin_sel   <= '1';    -- Immed
		ALU_func      <= "0000"; -- add			
		Mem_WrEn      <= '0';
		ByteOp        <= '0';  
		Instruction   <= "11000000000001010000000000001000";
        MM_RdData     <= "00000000000000001010101111111101";

		wait for clock_period;
		
		-- ori r3,r0,ABCD
		
		PC_sel <='0'; 			
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; -- Alu out 
		RF_B_sel  <='0';
		ImmExt <= "00";      -- zero fill
		ALU_Bin_sel <='1';   -- Immed
		ALU_func <="0011";   -- OR			
		Mem_WrEn  <='0';
	    ByteOp        <= '0';  
		Instruction   <= "11001100000000111010101111001101";
        MM_RdData     <= "00000000000011111010101111111101";
		wait for clock_period;
		
		-- sw r3 4(r0)		
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='0';
		RF_WrData_sel <='1'; -- Mem out dont care
		RF_B_sel  <='1';
		ImmExt <= "10";
		ALU_Bin_sel <='1';   -- Immed
		ALU_func  <="0000";	 -- add	
		Mem_WrEn  <='1'; 
		ByteOp        <= '1';  
		Instruction   <= "01111100000000110000000000000100";
        MM_RdData     <= "11110000000011111010101111111101";
		wait for clock_period;

		-- lw r10,-4(r5)		 
		PC_sel        <= '0'; 
		PC_LdEn       <= '1'; 
		RF_WrEn       <= '1';
		RF_WrData_sel <= '1';    -- Mem out 
		RF_B_sel      <= '0';
		ImmExt        <= "10";
		ALU_Bin_sel   <= '1';    -- Immed
		ALU_func      <= "0000"; -- add		
		Mem_WrEn      <= '0';  
		ByteOp        <= '1';  
		Instruction   <= "00111100101010101111111111111100";
        MM_RdData     <= "11111111000011111010101111111101";
		wait for clock_period;
		
		-- lb r16 4(r0)		
		PC_sel        <= '0'; 
		PC_LdEn       <= '1'; 
		RF_WrEn       <= '1';
		RF_WrData_sel <= '1';    -- Mem out 
		RF_B_sel      <= '0';
		ImmExt        <= "10";
		ALU_Bin_sel   <= '1';    -- Immed
		ALU_func      <= "0000"; -- add		
		Mem_WrEn      <= '0';  
        ByteOp        <= '1';  
		Instruction   <= "00001100000100000000000000000100";
        MM_RdData     <= "11111111000011111010101110000101";
        
		wait for clock_period;
		
		-- nand r4,r0,r16
		PC_sel        <= '0'; 
		PC_LdEn       <= '1'; 
		RF_WrEn       <= '1';
		RF_WrData_sel <= '1';    -- Mem out 
		RF_B_sel      <= '1';    -- rt
		ImmExt        <= "00";   -- dont care
		ALU_Bin_sel   <= '0';    -- RF_B
		ALU_func      <= "0000"; -- nand		
		Mem_WrEn      <= '0';  
		ByteOp        <= '1';  
		Instruction   <= "10000001010001001000011010100000";
        MM_RdData     <= "11111111000011111010101111111111";
    
      wait;
   end process;


end Behavioral_Datapath_Tb;
