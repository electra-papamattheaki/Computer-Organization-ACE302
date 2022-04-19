----------------------------------------------------------------------------------
-- Instruction Decoding Stage aka DECSTAGE.
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

entity DECSTAGE is
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
end DECSTAGE;

architecture Behavioral_DecStage of DECSTAGE is

-- Register File Component
component RegisterFile is
    Port ( Clk :   in  STD_LOGIC;                      -- Clock ofc
           Rst :   in  STD_LOGIC;                      -- Reset 
           Ard1 :  in  STD_LOGIC_VECTOR (4 downto 0);  -- 1st Reg Address for Reading
           Ard2 :  in  STD_LOGIC_VECTOR (4 downto 0);  -- 2nd Reg Address for Reading
           Awr :   in  STD_LOGIC_VECTOR (4 downto 0);  -- Reg Address for Writing
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0); -- 1st Reg Data Out
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0); -- 2nd Reg Data Out
           Din :   in  STD_LOGIC_VECTOR (31 downto 0); -- Data for Writing
           WrEn :  in  STD_LOGIC);                     -- Write Enable
 end component; 
 
 -- Mux2to1 Component
 component Mux2to1 is
    Port ( mux_in0 : in  STD_LOGIC_VECTOR(31 downto 0);
           mux_in1 : in  STD_LOGIC_VECTOR(31 downto 0);
           mux_sel : in  STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR(31 downto 0));
end component;

 -- Mux2to1 5 bit output Component
 component Mux2to1_5bit is
    Port ( mux_in0 : in  STD_LOGIC_VECTOR(4 downto 0);
           mux_in1 : in  STD_LOGIC_VECTOR(4 downto 0);
           mux_sel : in  STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR(4 downto 0));
end component;

-- Processing Unit component
component ProcessingUnit is
    Port ( ImmedExt :  in  STD_LOGIC_VECTOR (1 downto 0);
           unit_in :   in  STD_LOGIC_VECTOR (15 downto 0);
           unit_out :  out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal mux_out_temp : std_logic_vector (31 downto 0);
signal read_register2 : std_logic_vector (4 downto 0);

begin

MuxForRF: Mux2to1 Port map ( mux_in0 => ALU_out,
                             mux_in1 => MEM_out,
                             mux_sel => RF_WrData_sel,
                             mux_out => mux_out_temp);
                             
Mux5bit: Mux2to1_5bit Port map ( mux_in0 => Instr(20 downto 16),
                                 mux_in1 => Instr(15 downto 11),
                                 mux_sel => RF_B_sel,
                                 mux_out => read_register2);

DecProcessingUnit: ProcessingUnit Port map ( ImmedExt  => ImmExt,
                                             unit_in   => Instr(15 downto 0),
                                             unit_out  => Immed);
                                             
DecRF: RegisterFile Port map ( Clk   => Clk,
                               Rst   => Rst,
                               Ard1  => Instr(25 downto 21),
                               Ard2  => read_register2,
                               Awr   => Instr(20 downto 16),
                               Dout1 => RF_A,
                               Dout2 => RF_B,
                               Din   => mux_out_temp,
                               WrEn  => RF_WrEn);
                                                              
end Behavioral_DecStage;


