----------------------------------------------------------------------------------
-- Register File.
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

entity RegisterFile is
    Port ( Clk :   in  STD_LOGIC;                      -- Clock ofc
           Rst :   in  STD_LOGIC;                      -- Reset 
           Ard1 :  in  STD_LOGIC_VECTOR (4 downto 0);  -- 1st Reg Address for Reading
           Ard2 :  in  STD_LOGIC_VECTOR (4 downto 0);  -- 2nd Reg Address for Reading
           Awr :   in  STD_LOGIC_VECTOR (4 downto 0);  -- Reg Address for Writing
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0); -- 1st Reg Data Out
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0); -- 2nd Reg Data Out
           Din :   in  STD_LOGIC_VECTOR (31 downto 0); -- Data for Writing
           WrEn :  in  STD_LOGIC);                     -- Write Enable
                    
end RegisterFile;

architecture Behavioral_RF of RegisterFile is

    -- Register Component located in another module
    component charis_Register is
        port  ( CLK :     in  STD_LOGIC;
                RST :     in  STD_LOGIC;
                WE :      in  STD_LOGIC;
                DataIn :  in  STD_LOGIC_VECTOR (31 downto 0);
                DataOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    -- Decoder Component located in another module
    component Decoder is
        Port ( decoder_in :  in  STD_LOGIC_VECTOR (4 downto 0);
               decoder_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    -- Multiplexer Component located in another module
    component Multiplexer is
        Port ( MuxIn0 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn1 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn2 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn3 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn4 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn5 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn6 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn7 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn8 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn9 :  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn10 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn11 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn12:  in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn13 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn14 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn15 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn16 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn17 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn18 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn19 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn20 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn21 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn22 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn23 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn24 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn25 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn26 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn27 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn28 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn29 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn30 : in  STD_LOGIC_VECTOR (31 downto 0);
               MuxIn31 : in  STD_LOGIC_VECTOR (31 downto 0); 
               MuxSel :  in  STD_LOGIC_VECTOR (4  downto 0);   
               MuxOut :  out STD_LOGIC_VECTOR (31 downto 0));
    end component;  
  
  -- Decoder's output Signal
  signal Decoder_out: std_logic_vector (31 downto 0);
  
  -- Write Enable Signals
  signal WE_Register0 : std_logic;
  signal WE_Register1 : std_logic;
  signal WE_Register2 : std_logic;
  signal WE_Register3 : std_logic;
  signal WE_Register4 : std_logic;
  signal WE_Register5 : std_logic;
  signal WE_Register6 : std_logic;
  signal WE_Register7 : std_logic;
  signal WE_Register8 : std_logic;
  signal WE_Register9 : std_logic;
  signal WE_Register10 :std_logic;
  signal WE_Register11 :std_logic;
  signal WE_Register12 :std_logic;
  signal WE_Register13 :std_logic;
  signal WE_Register14 :std_logic;
  signal WE_Register15 :std_logic;
  signal WE_Register16 :std_logic;
  signal WE_Register17 :std_logic;
  signal WE_Register18 :std_logic;
  signal WE_Register19 :std_logic;
  signal WE_Register20 :std_logic;
  signal WE_Register21 :std_logic;
  signal WE_Register22 :std_logic;
  signal WE_Register23 :std_logic;
  signal WE_Register24 :std_logic;
  signal WE_Register25 :std_logic;
  signal WE_Register26 :std_logic;
  signal WE_Register27 :std_logic;
  signal WE_Register28 :std_logic;
  signal WE_Register29 :std_logic;
  signal WE_Register30 :std_logic;
  signal WE_Register31 :std_logic; 
  
  -- Register outputs aka Mux Inputs 
  signal DataOut0 :  std_logic_vector (31 downto 0);
  signal DataOut1 :  std_logic_vector (31 downto 0);
  signal DataOut2 :  std_logic_vector (31 downto 0);
  signal DataOut3 :  std_logic_vector (31 downto 0);
  signal DataOut4 :  std_logic_vector (31 downto 0);
  signal DataOut5 :  std_logic_vector (31 downto 0);
  signal DataOut6 :  std_logic_vector (31 downto 0);
  signal DataOut7 :  std_logic_vector (31 downto 0);
  signal DataOut8 :  std_logic_vector (31 downto 0);
  signal DataOut9 :  std_logic_vector (31 downto 0);
  signal DataOut10 : std_logic_vector (31 downto 0);
  signal DataOut11 : std_logic_vector (31 downto 0);
  signal DataOut12 : std_logic_vector (31 downto 0);
  signal DataOut13 : std_logic_vector (31 downto 0);
  signal DataOut14 : std_logic_vector (31 downto 0);
  signal DataOut15 : std_logic_vector (31 downto 0);
  signal DataOut16 : std_logic_vector (31 downto 0);
  signal DataOut17 : std_logic_vector (31 downto 0);
  signal DataOut18 : std_logic_vector (31 downto 0);
  signal DataOut19 : std_logic_vector (31 downto 0);
  signal DataOut20 : std_logic_vector (31 downto 0);
  signal DataOut21 : std_logic_vector (31 downto 0);
  signal DataOut22 : std_logic_vector (31 downto 0);
  signal DataOut23 : std_logic_vector (31 downto 0);
  signal DataOut24 : std_logic_vector (31 downto 0);
  signal DataOut25 : std_logic_vector (31 downto 0);
  signal DataOut26 : std_logic_vector (31 downto 0);
  signal DataOut27 : std_logic_vector (31 downto 0);
  signal DataOut28 : std_logic_vector (31 downto 0);
  signal DataOut29 : std_logic_vector (31 downto 0);
  signal DataOut30 : std_logic_vector (31 downto 0);
  signal DataOut31 : std_logic_vector (31 downto 0);
    
begin

    -- Creating the Decoder first
    Dec: Decoder 
        port map ( decoder_in  => Awr,
                   decoder_out =>  Decoder_out);
                  
    -- Creating 32 Registers
    Register0: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register0,
                   DataIn => Din,
                   DataOut => DataOut0);

    Register1: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register1,
                   DataIn => Din,
                   DataOut => DataOut1);
                   
    Register3: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register3,
                   DataIn => Din,
                   DataOut => DataOut3);
    Register4: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register4,
                   DataIn => Din,
                   DataOut => DataOut4);
    Register5: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register5,
                   DataIn => Din,
                   DataOut => DataOut5);
                   
     Register6: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register6,
                   DataIn => Din,
                   DataOut => DataOut6);
    
     Register7: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register7,
                   DataIn => Din,
                   DataOut => DataOut7); 
                   
     Register8: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register8,
                   DataIn => Din,
                   DataOut => DataOut8);   
                   
    Register9: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register9,
                   DataIn => Din,
                   DataOut => DataOut9);
                   
    Register10: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register10,
                   DataIn => Din,
                   DataOut => DataOut10);
                   
    Register11: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register11,
                   DataIn => Din,
                   DataOut => DataOut11);   
                   
     Register12: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register12,
                   DataIn => Din,
                   DataOut => DataOut12);
                   
     Register13: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register13,
                   DataIn => Din,
                   DataOut => DataOut13);
                   
    Register14: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register14,
                   DataIn => Din,
                   DataOut => DataOut14);
                   
    Register15: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register15,
                   DataIn => Din,
                   DataOut => DataOut15);
                   
     Register16: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register16,
                   DataIn => Din,
                   DataOut => DataOut16);  
                   
     Register17: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register17,
                   DataIn => Din,
                   DataOut => DataOut17); 
                   
    Register18: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register18,
                   DataIn => Din,
                   DataOut => DataOut18); 
                   
    Register19: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register19,
                   DataIn => Din,
                   DataOut => DataOut19);  
                   
    Register20: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register20,
                   DataIn => Din,
                   DataOut => DataOut20);  
                   
    Register21: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register21,
                   DataIn => Din,
                   DataOut => DataOut21);  
                   
    Register22: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register22,
                   DataIn => Din,
                   DataOut => DataOut22); 
                   
    Register23: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register23,
                   DataIn => Din,
                   DataOut => DataOut23);
                   
    Register24: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register24,
                   DataIn => Din,
                   DataOut => DataOut24); 
                   
    Register25: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register25,
                   DataIn => Din,
                   DataOut => DataOut25);
                   
    Register26: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register26,
                   DataIn => Din,
                   DataOut => DataOut26); 
                   
    Register27: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register27,
                   DataIn => Din,
                   DataOut => DataOut27); 
                   
    Register28: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register28,
                   DataIn => Din,
                   DataOut => DataOut28); 
                   
    Register29: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register29,
                   DataIn => Din,
                   DataOut => DataOut29);  
                   
    Register30: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register30,
                   DataIn => Din,
                   DataOut => DataOut30);
                   
    Register31: charis_Register
        port map ( CLK => Clk,
                   RST => Rst,
                   WE => WE_Register31,
                   DataIn => Din,
                   DataOut => DataOut31); 
                   
    -- Creating 2 Multiplexers
    Mux1: Multiplexer
        port map ( MuxIn0  => DataOut0,
                   MuxIn1  => DataOut1,
                   MuxIn2  => DataOut2,
                   MuxIn3  => DataOut3,
                   MuxIn4  => DataOut4,
                   MuxIn5  => DataOut5,
                   MuxIn6  => DataOut6,
                   MuxIn7  => DataOut7,
                   MuxIn8  => DataOut8,
                   MuxIn9  => DataOut9,
                   MuxIn10 => DataOut10,
                   MuxIn11 => DataOut11,
                   MuxIn12 => DataOut12,
                   MuxIn13 => DataOut13,
                   MuxIn14 => DataOut14,
                   MuxIn15 => DataOut15,
                   MuxIn16 => DataOut16,
                   MuxIn17 => DataOut17,
                   MuxIn18 => DataOut18,
                   MuxIn19 => DataOut19,
                   MuxIn20 => DataOut20,
                   MuxIn21 => DataOut21,
                   MuxIn22 => DataOut22,
                   MuxIn23 => DataOut23,
                   MuxIn24 => DataOut24,
                   MuxIn25 => DataOut25,
                   MuxIn26 => DataOut26,
                   MuxIn27 => DataOut27,
                   MuxIn28 => DataOut28,
                   MuxIn29 => DataOut29,
                   MuxIn30 => DataOut30,
                   MuxIn31 => DataOut31,
                   MuxSel  => Ard1,
                   MuxOut  => Dout1);
                   
    Mux2: Multiplexer
        port map ( MuxIn0  => DataOut0,
                   MuxIn1  => DataOut1,
                   MuxIn2  => DataOut2,
                   MuxIn3  => DataOut3,
                   MuxIn4  => DataOut4,
                   MuxIn5  => DataOut5,
                   MuxIn6  => DataOut6,
                   MuxIn7  => DataOut7,
                   MuxIn8  => DataOut8,
                   MuxIn9  => DataOut9,
                   MuxIn10 => DataOut10,
                   MuxIn11 => DataOut11,
                   MuxIn12 => DataOut12,
                   MuxIn13 => DataOut13,
                   MuxIn14 => DataOut14,
                   MuxIn15 => DataOut15,
                   MuxIn16 => DataOut16,
                   MuxIn17 => DataOut17,
                   MuxIn18 => DataOut18,
                   MuxIn19 => DataOut19,
                   MuxIn20 => DataOut20,
                   MuxIn21 => DataOut21,
                   MuxIn22 => DataOut22,
                   MuxIn23 => DataOut23,
                   MuxIn24 => DataOut24,
                   MuxIn25 => DataOut25,
                   MuxIn26 => DataOut26,
                   MuxIn27 => DataOut27,
                   MuxIn28 => DataOut28,
                   MuxIn29 => DataOut29,
                   MuxIn30 => DataOut30,
                   MuxIn31 => DataOut31,
                   MuxSel  => Ard2,
                   MuxOut  => Dout2);
                    
    -- AND gates have 2ns delay
    WE_Register0  <= '0'; -- Always disabled Register0 = 0
    WE_Register1  <= Decoder_out(1)  and WrEn after 2ns;
    WE_Register2  <= Decoder_out(2)  and WrEn after 2ns;
    WE_Register3  <= Decoder_out(3)  and WrEn after 2ns;
    WE_Register4  <= Decoder_out(4)  and WrEn after 2ns;
    WE_Register5  <= Decoder_out(5)  and WrEn after 2ns;
    WE_Register6  <= Decoder_out(6)  and WrEn after 2ns;
    WE_Register7  <= Decoder_out(7)  and WrEn after 2ns;
    WE_Register8  <= Decoder_out(8)  and WrEn after 2ns;
    WE_Register9  <= Decoder_out(9)  and WrEn after 2ns;
    WE_Register10 <= Decoder_out(10) and WrEn after 2ns;
    WE_Register11 <= Decoder_out(11) and WrEn after 2ns;
    WE_Register12 <= Decoder_out(12) and WrEn after 2ns;
    WE_Register13 <= Decoder_out(13) and WrEn after 2ns;
    WE_Register14 <= Decoder_out(14) and WrEn after 2ns;
    WE_Register15 <= Decoder_out(15) and WrEn after 2ns;
    WE_Register16 <= Decoder_out(16) and WrEn after 2ns;
    WE_Register17 <= Decoder_out(17) and WrEn after 2ns;
    WE_Register18 <= Decoder_out(18) and WrEn after 2ns;
    WE_Register19 <= Decoder_out(19) and WrEn after 2ns;
    WE_Register20 <= Decoder_out(20) and WrEn after 2ns;
    WE_Register21 <= Decoder_out(21) and WrEn after 2ns;
    WE_Register22 <= Decoder_out(22) and WrEn after 2ns;
    WE_Register23 <= Decoder_out(23) and WrEn after 2ns;
    WE_Register24 <= Decoder_out(24) and WrEn after 2ns;
    WE_Register25 <= Decoder_out(25) and WrEn after 2ns;
    WE_Register26 <= Decoder_out(26) and WrEn after 2ns;
    WE_Register27 <= Decoder_out(27) and WrEn after 2ns;
    WE_Register28 <= Decoder_out(28) and WrEn after 2ns;
    WE_Register29 <= Decoder_out(29) and WrEn after 2ns;
    WE_Register30 <= Decoder_out(30) and WrEn after 2ns;
    WE_Register31 <= Decoder_out(31) and WrEn after 2ns;
        
--    process
--        begin
--            wait until Clk'event and Clk = '1'; 
--    end process;

end Behavioral_RF;
