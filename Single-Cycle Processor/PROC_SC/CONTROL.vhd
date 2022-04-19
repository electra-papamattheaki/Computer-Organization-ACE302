----------------------------------------------------------------------------------
-- Control. 
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

entity CONTROL is
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
end CONTROL;

architecture Behavioral_Control of CONTROL is

signal opcode :    std_logic_vector (5 downto 0);
signal func   :    std_logic_vector (5 downto 0);
signal Rd :        std_logic_vector (4 downto 0);
signal Rs :        std_logic_vector (4 downto 0);

begin    

    opcode    <= Instruction (31 downto 26);
    Rd        <= Instruction (25 downto 21);
    Rs        <= Instruction (20 downto 16);
    func      <= Instruction(5 downto 0);  
      
    determineSignals: process(opcode,Instruction)
        begin
            case opcode is
                when "100000" => -- Need ALU                 
                    
                    if func = "110000" then    -- add
                        ALU_func <= "0000";
                    elsif func = "110001" then -- sub 
                        ALU_func <= "0001"; 
                    elsif func = "110010" then -- and
                        ALU_func <= "0001";
                    elsif  func = "110011" then -- or
                        ALU_func <= "0011";                    
                    elsif func = "110100" then -- not
                        ALU_func <= "0100";
                    elsif func = "110101" then -- nand
                        ALU_func <= "0101";
                    elsif func = "110110" then -- nor
                        ALU_func <= "0110";       
                    elsif func = "111000" then -- sra
                        ALU_func <= "1000";                   
                    elsif func =  "111001" then -- srl
                        ALU_func <= "1001";                   
                    elsif func = "111010" then -- sll
                        ALU_func <= "1010";
                    elsif func = "111100" then -- rol
                    ALU_func <= "1100";                      
                    elsif func = "111101" then -- ror               
                    ALU_func <= "1101";
                    end if;
                    
                    ALU_Bin_sel   <= '0';   
                    RF_B_Sel      <= '0'; -- RF[rt]
                    RF_WrData_sel <= '0'; -- data from ALU
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0'; 
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0';
                     
                when "111000" => -- li
                    ALU_func      <= "0000";
                    ImmExt        <= "10"; -- SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '1'; -- B = Immed
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0';
                     
                when "111001" => -- lui
                    ALU_func      <= "0000"; 
                    ImmExt        <= "01"; -- <<16 ZeroFill
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '0'; 
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1'; 
                    MEM_WrEn      <= '0'; 
                    
                when "110000" => --  addi
                    ALU_func      <= "0000";
                    ImmExt        <= "10"; -- SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '0'; -- B = Immed
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '1'; 
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                when "110010" => -- nandi
                    ALU_func      <= "0000";
                    ImmExt        <= "00"; -- ZeroFill
                    ALU_Bin_sel   <= '1'; 
                    RF_B_Sel      <= '0'; 
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    
                when "110011" => -- ori
                    ALU_func      <= "0000";
                    ImmExt        <= "00"; -- ZeroFill
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '0'; 
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    
                when "111111" => -- b
                    ALU_func      <= "0000"; 
                    ImmExt        <= "11"; -- <<2 SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '1'; 
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '0';
                    PC_Sel        <= '1';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    
                when "000000" => -- beq
                    ALU_func      <= "0000";
                    ImmExt        <= "11"; -- <<2 SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '1'; 
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '0';
                    if Rs = Rd then
                    PC_Sel        <= '1';
                    else
                    PC_Sel        <= '0';
                    end if;
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    
                when "000001" => -- bne
                    ALU_func      <= "0000";
                    ImmExt        <= "11"; -- <<2 SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '1';  
                    RF_WrData_sel <= '0';
                    RF_WrEn       <= '0';
                    if Rs = Rd then
                    PC_Sel        <= '0';
                    else
                    PC_Sel        <= '1';
                    end if;
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    
                when "000011" => -- lb
                    ALU_func      <= "0000";
                    ImmExt        <= "10"; -- SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '0';
                    RF_WrData_sel <= '1'; -- Data from Memory
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    ByteOp        <= '1';
                    
                when "000111" => -- sb
                    ALU_func      <= "0000";
                    ImmExt        <= "10"; -- SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '1'; 
                    RF_WrData_sel <= '1';
                    RF_WrEn       <= '0';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '1'; 
                    ByteOp        <= '1'; 
                    
                when "001111" => -- lw
                    ALU_func      <= "0000";
                    ImmExt        <= "10"; -- SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '0'; 
                    RF_WrData_sel <= '1';
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0'; 
                    ByteOp        <= '0'; 
                    
                when "011111" => -- sw
                    ALU_func      <= "0000";
                    ImmExt        <= "10"; -- SignExtend
                    ALU_Bin_sel   <= '1';
                    RF_B_Sel      <= '1'; 
                    RF_WrData_sel <= '1'; 
                    RF_WrEn       <= '1';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '1';
                    ByteOp        <= '0';
                    
                when others =>
                    ALU_func      <= "0000";
                    ImmExt        <= "00"; -- SignExtend
                    ALU_Bin_sel   <= '0';
                    RF_B_Sel      <= '0'; 
                    RF_WrData_sel <= '0'; 
                    RF_WrEn       <= '0';
                    PC_Sel        <= '0';
                    PC_LdEn       <= '1';
                    MEM_WrEn      <= '0';
                    ByteOp        <= '0'; 
            end case;
    end process;
                       
end Behavioral_Control;
