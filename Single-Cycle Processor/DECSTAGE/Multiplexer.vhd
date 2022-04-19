----------------------------------------------------------------------------------
-- 32-bit input Multiplexer.
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

entity Multiplexer is
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
end Multiplexer;

architecture Behavioral_Multiplexer of Multiplexer is

signal MuxOut_tmp : std_logic_vector (31 downto 0);

begin
    
    with (MuxSel) select
        MuxOut_tmp <= MuxIn0  when "00000", -- 0
                      MuxIn1  when "00001", -- 1
                      MuxIn2  when "00010", -- 2
                      MuxIn3  when "00011", -- 3
                      MuxIn4  when "00100", -- 4
                      MuxIn5  when "00101", -- 5
                      MuxIn6  when "00110", -- 6
                      MuxIn7  when "00111", -- 7
                      MuxIn8  when "01000", -- 8
                      MuxIn9  when "01001", -- 9
                      MuxIn10 when "01010", -- 10
                      MuxIn11 when "01011", -- 11
                      MuxIn12 when "01100", -- 12
                      MuxIn13 when "01101", -- 13
                      MuxIn14 when "01110", -- 14
                      MuxIn15 when "01111", -- 15
                      MuxIn16 when "10000", -- 16
                      MuxIn17 when "10001", -- 17
                      MuxIn18 when "10010", -- 18
                      MuxIn19 when "10011", -- 19
                      MuxIn20 when "10100", -- 20
                      MuxIn21 when "10101", -- 21
                      MuxIn22 when "10110", -- 22
                      MuxIn23 when "10111", -- 23
                      MuxIn24 when "11000", -- 24
                      MuxIn25 when "11001", -- 25
                      MuxIn26 when "11010", -- 26
                      MuxIn27 when "11011", -- 27
                      MuxIn28 when "11100", -- 28
                      MuxIn29 when "11101", -- 29
                      MuxIn30 when "11110", -- 30
                      MuxIn31 when "11111", -- 31
                      MuxIn31 when others;  -- all off
                      
       MuxOut <= MuxOut_tmp after 10ns;

end Behavioral_Multiplexer;
