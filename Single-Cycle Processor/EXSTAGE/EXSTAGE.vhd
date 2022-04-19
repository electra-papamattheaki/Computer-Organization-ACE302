----------------------------------------------------------------------------------
-- Execution Stage.
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

entity EXSTAGE is
    Port ( RF_A :        in  STD_LOGIC_VECTOR (31 downto 0); -- RF[rs]
           RF_B :        in  STD_LOGIC_VECTOR (31 downto 0); -- RF[rt] or RF[rd]
           Immed :       in  STD_LOGIC_VECTOR (31 downto 0); -- Immediate
           ALU_Bin_sel : in  STD_LOGIC;                      -- Selection of ALU's B input (1-> Immed, 0-> RF_B)
           ALU_func :    in  STD_LOGIC_VECTOR (3 downto 0);  -- ALU's function
           ALU_out :     out STD_LOGIC_VECTOR (31 downto 0); -- ALU's output
           ALU_zero :    out STD_LOGIC;                     -- Zero flag
           ALU_Cout :    out STD_LOGIC;                     -- Carry out
           ALU_Ovf :     out STD_LOGIC);                    -- Overflow
end EXSTAGE;

architecture Behavioral_Exstage of EXSTAGE is

-- Component of ALU 
component ALU is
    Port ( A :      in  STD_LOGIC_VECTOR (31 downto 0);
           B :      in  STD_LOGIC_VECTOR (31 downto 0);
           Op :     in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (31 downto 0);
           Zero :   out STD_LOGIC;
           Cout :   out STD_LOGIC;
           Ovf :    out STD_LOGIC
         );
end component;

-- Component of Mux2to1
component Mux2to1 is
    Port ( mux_in0 : in  STD_LOGIC_VECTOR(31 downto 0);
           mux_in1 : in  STD_LOGIC_VECTOR(31 downto 0);
           mux_sel : in  STD_LOGIC;
           mux_out : out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal Bin : std_logic_vector(31 downto 0); -- Mux out and B input

begin

ExStage_Mux2to1: Mux2to1 Port Map ( mux_in0 => RF_B,
                                    mux_in1 => Immed, 
                                    mux_sel => ALU_Bin_sel,
                                    mux_out => Bin);
                              
ExStage_ALU: ALU Port Map ( A      => RF_A,
                            B      => Bin,
                            Op     => ALU_func,
                            Output => ALU_out,
                            Zero   => ALU_zero,
                            Cout   => ALU_Cout,
                            Ovf    => ALU_Ovf);                         

end Behavioral_Exstage;
