----------------------------------------------------------------------------------
-- Datapath. 
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

entity DATAPATH is
    
    Port ( Clock :         in  STD_LOGIC;                       -- Clock
           Rst :           in  STD_LOGIC;                       -- Reset
           Instruction :   in  STD_LOGIC_VECTOR (31 downto 0);  -- Instruction
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
           
end DATAPATH;

architecture Behavioral_Datapath of DATAPATH is

    -- Instruction Fetch Stage Component
    component IFSTAGE is
        Port ( Clk :      in  STD_LOGIC;                        -- clock
               Reset :    in  STD_LOGIC;                        -- reset
               PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);   -- Immed value for b,beq,bne instructions
               PC_sel :   in  STD_LOGIC;                        -- 0 -> PC+4 , 1 -> PC+4+SignExt(Immed)*4
               PC_LdEn :  in  STD_LOGIC;                        -- enable writing on PC
               PC :       out STD_LOGIC_VECTOR (31 downto 0));  -- instruction address in memory
    end component;
    
    -- Instruction Decoding Stage Component
    component DECSTAGE is
        Port ( Clk :           in  STD_LOGIC;                       -- clock
               Rst :           in  STD_LOGIC;                        -- reset
               Instr :         in  STD_LOGIC_VECTOR (31 downto 0);  -- instruction to be decoded
               RF_WrEn :       in  STD_LOGIC;                       -- write enable register
               ALU_out :       in  STD_LOGIC_VECTOR (31 downto 0);  -- data to be written coming from alu
               MEM_out :       in  STD_LOGIC_VECTOR (31 downto 0);  -- data to be written coming from ram
               RF_WrData_sel : in  STD_LOGIC;                       -- where data's from 0 -> ALU, 1 -> MEM
               RF_B_sel :      in  STD_LOGIC;                       -- determine 2nd reading register 0 -> ?nstr(15-11), 1 -> ?nstr(20-16)
               ImmExt :        in  STD_LOGIC_VECTOR (1 downto 0);   -- determines whether we have zero-filling , sign-extension or shift
               Immed :         out STD_LOGIC_VECTOR (31 downto 0);  -- immediate value
               RF_A :          out STD_LOGIC_VECTOR (31 downto 0);  -- 1st Register's value
               RF_B :          out STD_LOGIC_VECTOR (31 downto 0)); -- 2nd Register's value
    end component;
   
    -- Execution Stage Component
    component EXSTAGE is
        Port ( RF_A :        in  STD_LOGIC_VECTOR (31 downto 0); -- RF[rs]
               RF_B :        in  STD_LOGIC_VECTOR (31 downto 0); -- RF[rt] or RF[rd]
               Immed :       in  STD_LOGIC_VECTOR (31 downto 0); -- Immediate
               ALU_Bin_sel : in  STD_LOGIC;                      -- Selection of ALU's B input (1-> Immed, 0-> RF_B)
               ALU_func :    in  STD_LOGIC_VECTOR (3 downto 0);  -- ALU's function
               ALU_out :     out STD_LOGIC_VECTOR (31 downto 0); -- ALU's output
               ALU_zero :    out STD_LOGIC;                     -- Zero flag
               ALU_Cout :    out STD_LOGIC;                     -- Carry out
               ALU_Ovf :     out STD_LOGIC);                    -- Overflow
    end component;
    
    -- Memory Stage Component
    component MEMSTAGE is 
        Port ( ByteOp :       in  STD_LOGIC;
               Mem_WrEn :     in  STD_LOGIC;
               ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
               MEM_DataIn :   in  STD_LOGIC_VECTOR (31 downto 0);
               MEM_DataOut :  out STD_LOGIC_VECTOR (31 downto 0);
               MM_Addr :      out STD_LOGIC_VECTOR (31 downto 0);
               MM_WrEn :      out STD_LOGIC;
               MM_WrData :    out STD_LOGIC_VECTOR (31 downto 0);
               MM_RdData :    in  STD_LOGIC_VECTOR (31 downto 0));
   end component;
   
   signal Immediate_sig :        std_logic_vector (31 downto 0); -- Immediate
   signal RF_A_sig :             std_logic_vector (31 downto 0); -- RF[rs]
   signal RF_B_sig :             std_logic_vector (31 downto 0); -- RF[rt] or RF[rd]
   signal ALU_out_sig :          std_logic_vector (31 downto 0); -- ALU's Result
   signal MEM_out_sig :          std_logic_vector (31 downto 0); -- MEM's output
     
begin

    IFSTAGE_DATAPATH : IFSTAGE   Port Map (  Clk           => Clock,
                                             Reset         => Rst,
                                             PC_Immed      => Immediate_sig,
                                             PC_sel        => PC_sel,
                                             PC_LdEn       => PC_LdEn,
                                             PC            => PC);
                                          
    DECSTAGE_DATAPATH : DECSTAGE Port Map (  Clk           => Clock,
                                             Rst           => Rst,
                                             Instr         => Instruction,
                                             RF_WrEn       => RF_WrEn,
                                             ALU_out       => ALU_out_sig,
                                             MEM_out       => MEM_out_sig,
                                             RF_WrData_sel => RF_WrData_sel,
                                             RF_B_sel      => RF_B_sel,
                                             ImmExt        => ImmExt,
                                             Immed         => Immediate_sig,
                                             RF_A          => RF_A_sig,
                                             RF_B          => RF_B_sig);
                                            
     EXSTAGE_DATAPATH : EXSTAGE  Port Map (  RF_A          => RF_A_sig,
                                             RF_B          => RF_B_sig,
                                             Immed         => Immediate_sig,
                                             ALU_Bin_sel   => ALU_Bin_sel,
                                             ALU_func      => ALU_func,
                                             ALU_out       => ALU_out_sig,
                                             ALU_zero      => ALU_zero);
                                            
     MEMSTAGE_DATAPATH : MEMSTAGE Port Map ( ByteOp        => ByteOp,
                                             Mem_WrEn      => Mem_WrEn,
                                             ALU_MEM_Addr  => ALU_out_sig,
                                             MEM_DataIn    => RF_B_sig,
                                             MEM_DataOut   => MEM_out_sig,
                                             MM_WrData     => MM_WrData,
                                             MM_WrEn       => MM_WrEn,
                                             MM_Addr       => MM_Addr,
                                             MM_RdData     => MM_RdData);
                       
end Behavioral_Datapath;
