---------------------------------------------------------------------------------- 
-- Engineer: Ilektra-Despoina Papamatthaiaki (2018030106)
-- 
-- Module Name: ALU - Behavioral 
--
-- Zero: '1' when the output is equal to zero(0) else '0'
-- Cout: '1' when there' a carry out else '0'
-- Ovf : '1' when there's overflow 
----------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
--use ieee.std_logic_unsigned.all; 
--use ieee.std_logic_signed.all; 
use ieee.std_logic_arith.all;

-- Entity of ALU -- 
entity ALU is
    Port ( A :      in  STD_LOGIC_VECTOR (31 downto 0);
           B :      in  STD_LOGIC_VECTOR (31 downto 0);
           Op :     in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (31 downto 0);
           Zero :   out STD_LOGIC;
           Cout :   out STD_LOGIC;
           Ovf :    out STD_LOGIC
         );
    end ALU;

architecture Behavioral_ALU of ALU is

    --use components located in other modules
    component Addition_32bit
        port ( a_add :      in  STD_LOGIC_VECTOR (31 downto 0);
               b_add :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_add : out STD_LOGIC_VECTOR (31 downto 0);
               cout_add :   out STD_LOGIC;
               ovf_add :    out STD_LOGIC);
      end component;
      
     component Subtraction_32bit
        port ( a_sub :      in  STD_LOGIC_VECTOR (31 downto 0);
               b_sub :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_sub : out STD_LOGIC_VECTOR (31 downto 0);
               cout_sub :   out STD_LOGIC;
               ovf_sub :    out STD_LOGIC);
     end component;
     
     component Arithmetic_Shift_Right
        port ( a_asr :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_asr : out STD_LOGIC_VECTOR (31 downto 0));
     end component;
     
     component Shift_Left_Logical
        port ( a_sll :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_sll : out STD_LOGIC_VECTOR (31 downto 0));
     end component;
     
     component Shift_Right_Logical
        port ( a_srl :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_srl : out STD_LOGIC_VECTOR (31 downto 0));
     end component;
     
     component Circular_Shift_Left
        port ( a_csl :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_csl : out STD_LOGIC_VECTOR (31 downto 0));
     end component;
     
     component Circular_Shift_Right
        port ( a_csr :      in  STD_LOGIC_VECTOR (31 downto 0);
               output_csr : out STD_LOGIC_VECTOR (31 downto 0));
     end component;

-- Output Signals
signal out_add: std_logic_vector (31 downto 0);
signal out_sub: std_logic_vector (31 downto 0);
signal out_asr: std_logic_vector (31 downto 0);
signal out_srl: std_logic_vector (31 downto 0);
signal out_sll: std_logic_vector (31 downto 0);
signal out_csr: std_logic_vector (31 downto 0);
signal out_csl: std_logic_vector (31 downto 0);
signal out_tmp: std_logic_vector (31 downto 0);

-- Cout signals 
signal cout_add: std_logic;
signal cout_sub: std_logic;

-- Ovf signals
signal ovf_add: std_logic;
signal ovf_sub: std_logic;

begin
    
     --map the in/out of the component to the entity contents and to the signal
    AddUnit: Addition_32bit
        port map ( a_add => A,
                   b_add => B,
                   output_add => out_add,
                   cout_add => cout_add,
                   ovf_add => ovf_add);
                   
    SubUnit: Subtraction_32bit
        port map ( a_sub => A,
                   b_sub => B,
                   output_sub => out_sub,
                   cout_sub => cout_sub,
                   ovf_sub => ovf_sub);
    
    ASR_Unit: Arithmetic_Shift_Right
        port map ( a_asr => A,
                   output_asr => out_asr);
                   
    SRL_Unit: Shift_Right_Logical
        port map ( a_srl => A,
                   output_srl => out_srl); 
               
    SLL_Unit: Shift_Left_Logical
        port map ( a_sll => A,
                   output_sll => out_sll);
                   
    CSL_Unit: Circular_Shift_Left
        port map ( a_csl => A,
                   output_csl => out_csl);
                   
    CSR_Unit: Circular_Shift_Right
        port map ( a_csr => A,
                   output_csr => out_csr);
    
 ------------------------------------------------------------
 
    -- Determining output using Concurrent conditional statement
--   
    out_tmp <= out_add  when Op = "0000"     -- Addition     
    else       out_sub  when Op = "0001"     -- Subtraction
    else       A and B  when Op = "0010"     -- Logical AND    
    else       A or B   when Op = "0011"     -- Logical OR
    else       not(A)   when Op = "0100"     -- Logical NOT     
    else       A nand B when Op = "0101"     -- Logical NAND
    else       A nor B  when Op = "0110"     -- Logical NOR
    else       out_asr  when Op = "1000"     -- Arithmetic Shift Right      
    else       out_srl  when Op = "1001"     -- Shift Right Logical
    else       out_sll  when Op = "1010"     -- Shift Left Logical     
    else       out_csl  when Op = "1100"     -- Circular Shift Left
    else       out_csr  when Op = "1101";    -- Circular Shift Right     
    
    Cout <= cout_add when Op = "0000"
    else    cout_sub when Op = "0001"
    else    '0';
    
    Ovf <=  ovf_add when Op = "0000"
    else    ovf_sub when Op = "0001"
    else    '0'; 
    
    Zero <= '1' when out_tmp = X"00000000"
    else '0';
    
    Output <= out_tmp after 10ns;
         
end Behavioral_ALU;


    
