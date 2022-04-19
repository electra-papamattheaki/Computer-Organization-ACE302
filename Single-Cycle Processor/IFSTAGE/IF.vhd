----------------------------------------------------------------------------------
-- Instruction Fetch Unit.
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

entity IFSTAGE is
    Port ( Clk :      in  STD_LOGIC;                        -- clock
           Reset :    in  STD_LOGIC;                        -- reset
           PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);   -- Immed value for b,beq,bne instructions
           PC_sel :   in  STD_LOGIC;                        -- 0 -> PC+4 , 1 -> PC+4+SignExt(Immed)*4
           PC_LdEn :  in  STD_LOGIC;                        -- enable writing on PC
           PC :       out STD_LOGIC_VECTOR (31 downto 0));  -- instruction address in memory
end IFSTAGE;

architecture Behavioral_IF of IFSTAGE is

-- Mux 2to1 Component
component Mux2to1 is
    Port ( mux_in0 : in  STD_LOGIC_VECTOR(31 downto 0);
           mux_in1 : in  STD_LOGIC_VECTOR(31 downto 0);
           mux_sel : in  STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR(31 downto 0));
end component;

-- PC Register Component
component PC_Register is 
    Port ( Clk :     in  STD_LOGIC;                         -- Clock
           Reset :   in  STD_LOGIC;                         -- Reset
           PC_in :   in  STD_LOGIC_VECTOR (31 downto 0);    -- Input data 
           PC_LdEn : in  STD_LOGIC;                         -- Load Enable (instruction fetch)
           PC_out :  out STD_LOGIC_VECTOR (31 downto 0));   -- Output data
end component;

-- Incrementor Component
component Incrementor is
    Port ( incr_in :  in  STD_LOGIC_VECTOR (31 downto 0);
           incr_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Adder Component
component Adder is
    Port ( adder_in0 : in  STD_LOGIC_VECTOR (31 downto 0);   -- 1st Input: PC + 4
           adder_in1 : in  STD_LOGIC_VECTOR (31 downto 0);   -- 2nd Input: PC_Immed
           adder_out : out STD_LOGIC_VECTOR (31 downto 0));  -- Output
end component;

signal pc_out_temp :    std_logic_vector(31 downto 0); -- PC Unit's temporary output also input in Incrementor Unit and in Memory
signal incr_out_temp :  std_logic_vector(31 downto 0); -- Incrementor's temporary output also input in Adder Unit and Mux
signal adder_out_temp : std_logic_vector(31 downto 0); -- Adder's temporary output also input in Mux  
signal mux_out_temp :   std_logic_vector(31 downto 0); -- Mux's temporary output also input in downto

begin

IncrementorUnit : Incrementor Port Map ( incr_in  => pc_out_temp,
                                         incr_out => incr_out_temp);
                                         
AdderUnit : Adder Port Map ( adder_in0 => PC_Immed,
                             adder_in1 => incr_out_temp,
                             adder_out => adder_out_temp);
                             
Mux : Mux2to1 Port Map ( mux_in0 => incr_out_temp,  -- PC + 4
                         mux_in1 => adder_out_temp, -- PC + 4 + Immed
                         mux_sel => PC_sel,
                         mux_out => mux_out_temp); 
                         
PC_Reg : PC_Register Port Map ( Clk     => Clk,
                                Reset   => Reset,
                                PC_in   => mux_out_temp,
                                PC_LdEn => PC_LdEn,
                                PC_out  => pc_out_temp);
                                
PC <= pc_out_temp; 
                                                                                                  
end Behavioral_IF;
