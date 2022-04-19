----------------------------------------------------------------------------------
-- PROC_SC , The final processor.  
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

entity PROC_SC is
    Port ( Clk :      in  STD_LOGIC;
           Reset :    in  STD_LOGIC);
end PROC_SC;

architecture Behavioral_PROC_SC of PROC_SC is

-- RAM Componenent.
component RAM is
    port ( clk : in std_logic;
           inst_addr : in  std_logic_vector(10 downto 0);
           inst_dout : out std_logic_vector(31 downto 0);
           data_we :   in  std_logic;
           data_addr : in  std_logic_vector(10 downto 0);
           data_din :  in  std_logic_vector(31 downto 0);
           data_dout : out std_logic_vector(31 downto 0));
end component;

-- Control Component
component CONTROL is
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

-- Datapath Component
 component DATAPATH  
    Port ( Clock :         in  STD_LOGIC;                       -- Clock
           Rst :           in  STD_LOGIC;                       -- Reset
           Instruction :   in  STD_LOGIC_VECTOR (31 downto 0); -- Instruction
           -- IFSTAGE
           PC_sel :        in  STD_LOGIC;                        -- 0 -> PC+4 , 1 -> PC+4+SignExt(Immed)*4
           PC_LdEn :       in  STD_LOGIC;                        -- enable writing on pc
           PC :            out STD_LOGIC_VECTOR (31 downto 0);
           -- DECSTAGE
           RF_WrEn :       in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel :      in  STD_LOGIC;
           ImmExt :        in  STD_LOGIC_VECTOR (1 downto 0);
           -- EXSTAGE           
           ALU_Bin_sel :   in  STD_LOGIC;                       -- Selection of ALU's B input (1-> Immed, 0-> RF_B)
           ALU_func :      in  STD_LOGIC_VECTOR (3 downto 0);   -- ALU's function
           ALU_Zero :      out STD_LOGIC;                       -- Zero flag
           -- MEMSTAGE
           ByteOp :        in  STD_LOGIC;                       -- Control signal for choosing lw/sw (0) or lb/sb(1)
           Mem_WrEn :      in  STD_LOGIC;                       -- write enable memory
           MM_Addr :       out STD_LOGIC_VECTOR (31 downto 0);  -- adress for module
           MM_WrEn :       out STD_LOGIC;                       -- write enable towards memory module
           MM_WrData :     out STD_LOGIC_VECTOR (31 downto 0);  -- data to be written in memory module
           MM_RdData :     in  STD_LOGIC_VECTOR (31 downto 0)); -- data read by memory module         
  end component;
  
signal Instruction_sig :   STD_LOGIC_VECTOR (31 downto 0);
signal ALU_func_sig :      STD_LOGIC_VECTOR (3 downto 0); 
signal ALU_Bin_Sel_sig :   STD_LOGIC;
signal ALU_zero_sig :      STD_LOGIC;	
signal RF_B_Sel_sig :      STD_LOGIC;
signal RF_WrData_sel_sig : STD_LOGIC;
signal RF_WrEn_sig :       STD_LOGIC;
signal PC_sel_sig :        STD_LOGIC;
signal PC_LdEn_sig :       STD_LOGIC;
signal PC_sig :            STD_LOGIC_VECTOR (31 downto 0);
signal ImmExt_sig:         STD_LOGIC_VECTOR (1 downto 0);
signal ByteOp_sig :        STD_LOGIC;    
signal MEM_WrEn_sig :      STD_LOGIC;
signal Mem_WrEn_sig_2 :    STD_LOGIC;
signal RF_A_sig :          STD_LOGIC_VECTOR (31 downto 0);
signal RF_B_sig :          STD_LOGIC_VECTOR (31 downto 0);
signal Memory_WrData :     STD_LOGIC_VECTOR (31 downto 0);
signal Memory_ReadData :   STD_LOGIC_VECTOR (31 downto 0);
signal Memory_Addr :       STD_LOGIC_VECTOR (31 downto 0);

begin

RAMinProcessor : RAM Port Map ( clk       => Clk,
                                inst_addr => PC_sig(12 downto 2),
                                inst_dout => Instruction_sig,
                                data_we   => MEM_WrEn_sig,
                                data_addr => Memory_Addr (12 downto 2),
                                data_din  => Memory_WrData,
                                data_dout => Memory_ReadData);
                                
DATAPATHinProcessor : DATAPATH Port Map ( Clock         => Clk,
                                          Rst           => Reset,
                                          Instruction   => Instruction_sig,
                                          PC_sel        => PC_sel_sig,
                                          PC_LdEn       => PC_LdEn_sig,
                                          PC            => PC_sig,
                                          RF_WrEn       => RF_WrEn_sig,
                                          RF_WrData_sel => RF_WrData_sel_sig,
                                          RF_B_sel      => RF_B_sel_sig,
                                          ImmExt        => ImmExt_sig,
                                          ALU_Bin_sel   => ALU_Bin_sel_sig,
                                          ALU_func      => ALU_func_sig,
                                          ByteOp        => ByteOp_sig,
                                          Mem_WrEn      => Mem_WrEn_sig_2,
                                          MM_RdData     => Memory_ReadData,
                                          ALU_Zero      => ALU_zero_sig,
                                          MM_Addr       => Memory_Addr,
                                          MM_WrEn       => Mem_WrEn_sig,
                                          MM_WrData     => Memory_WrData);

CONTROLinProcessor : CONTROL Port Map ( Reset         => Reset,
                                        Instruction   => Instruction_sig,
                                        ALU_func      => ALU_func_sig,
                                        ALU_zero      => ALU_zero_sig,
                                        ALU_Bin_Sel   => ALU_Bin_Sel_sig,
                                        RF_B_Sel      => RF_B_Sel_sig, 
                                        RF_WrData_sel => RF_WrData_sel_sig,
                                        RF_WrEn       => RF_WrEn_sig,
                                        PC_sel        => PC_sel_sig,
                                        PC_LdEn       => PC_LdEn_sig,
                                        ImmExt        => ImmExt_sig,
                                        ByteOp        => ByteOp_sig,
		                                MEM_WrEn      => Mem_WrEn_sig_2);

end Behavioral_PROC_SC;
