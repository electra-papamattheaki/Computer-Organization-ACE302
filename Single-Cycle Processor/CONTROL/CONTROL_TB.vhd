----------------------------------------------------------------------------------
-- Control TB
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

entity CONTROL_TB is
--  Port ( );
end CONTROL_TB;

architecture Behavioral of CONTROL_TB is

  component CONTROL
      Port ( Reset :         in   STD_LOGIC;
             Instruction :   in   STD_LOGIC_VECTOR (31 downto 0);
             ALU_zero :      in   STD_LOGIC; 
             ALU_func :      out  STD_LOGIC_VECTOR (3 downto 0); 
             ALU_Bin_Sel :   out  STD_LOGIC;
             RF_B_Sel :      out  STD_LOGIC;
             RF_WrData_sel : out  STD_LOGIC;
             RF_WrEn :       out  STD_LOGIC;
             PC_sel :        out  STD_LOGIC;
             PC_LdEn :       out  STD_LOGIC;
             ImmExt:         out  STD_LOGIC_VECTOR (1 downto 0);
             ByteOp :        out  STD_LOGIC;
  		     MEM_WrEn :      out  STD_LOGIC);
  end component;

  -- Input Signals   
  signal Reset:         STD_LOGIC := '0';
  signal Instruction:   STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
  signal ALU_zero :     STD_LOGIC := '0';
  
  -- Output Signals
  signal ALU_func:      STD_LOGIC_VECTOR (3 downto 0);
  signal ALU_Bin_Sel:   STD_LOGIC;
  signal RF_B_Sel:      STD_LOGIC;
  signal RF_WrData_sel: STD_LOGIC;
  signal RF_WrEn:       STD_LOGIC;
  signal PC_sel:        STD_LOGIC;
  signal PC_LdEn:       STD_LOGIC;
  signal ImmExt:        STD_LOGIC_VECTOR (1 downto 0);
  signal ByteOp:        STD_LOGIC;
  signal MEM_WrEn:      STD_LOGIC;

begin

  uut: CONTROL port map ( Reset         => Reset,
                          Instruction   => Instruction,
                          ALU_zero      => ALU_zero,
                          ALU_func      => ALU_func,
                          ALU_Bin_Sel   => ALU_Bin_Sel,
                          RF_B_Sel      => RF_B_Sel,
                          RF_WrData_sel => RF_WrData_sel,
                          RF_WrEn       => RF_WrEn,
                          PC_sel        => PC_sel,
                          PC_LdEn       => PC_LdEn,
                          ImmExt        => ImmExt,
                          ByteOp        => ByteOp,
                          MEM_WrEn      => MEM_WrEn );

  stimulus: process
  begin
  
    -- initialisation code
    Reset <= '1';
    wait for 100ns;
    Reset <= '0';
    
    -- R-TYPE INSTRUCTIONS
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110000"; -- Func for Addition
    wait for 100ns; 

    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110001"; -- Func for Subtraction
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110010"; -- Func for AND
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110011"; -- Func for OR
    wait for 100ns;
        
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110100"; -- Func for NOT
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110101"; -- Func for NAND
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "110110"; -- Func for NOR
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "111000"; -- Func for sra
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "111001"; -- Func for srl
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "111010"; -- Func for sll
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "111100"; -- Func for rol
    wait for 100ns;
    
    Instruction (31 downto 26) <= "100000"; -- Opcode
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 11) <= "00010";
    Instruction (10 downto  6) <= "00000";
    Instruction (5  downto  0) <= "111101"; -- Func for ror
    wait for 100ns;
    
    -- I-TYPE INSTRUCTIONS
    Instruction (31 downto 26) <= "111000"; -- Opcode LI 
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0001011111000100";  -- Immediate
    wait for 100ns;

    Instruction (31 downto 26) <= "111001"; -- Opcode LUI 
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "1010011111010100";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "110000"; -- Opcode ADDI 
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "1010011111010101";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "110010"; -- Opcode NANDI 
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "1101011111000100";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "110011"; -- Opcode ORI 
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "1101011111000100";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "111111"; -- Opcode B 
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0101011111000100";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "000000"; -- Opcode BEQ
    Instruction (25 downto 21) <= "00000"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0000011111000100";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "000001"; -- Opcode BNE
    Instruction (25 downto 21) <= "00000"; 
    Instruction (20 downto 16) <= "00001";
    Instruction (15 downto 0) <=  "0000011111110100";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "000011"; -- Opcode LB
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0011011111000111";  -- Immediate
    wait for 100ns;
    
    Instruction (31 downto 26) <= "000111"; -- Opcode SB
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0011011111000111";  -- Immediate
    wait for 100ns;

    Instruction (31 downto 26) <= "001111"; -- Opcode LW
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0011011111000111";  -- Immediate
    wait for 100ns;
        
    Instruction (31 downto 26) <= "011111"; -- Opcode SW
    Instruction (25 downto 21) <= "00001"; 
    Instruction (20 downto 16) <= "00000";
    Instruction (15 downto 0) <=  "0011011111000111";  -- Immediate
    wait for 100ns;
    wait;
  end process;


end Behavioral;
