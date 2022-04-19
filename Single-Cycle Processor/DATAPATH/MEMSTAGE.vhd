----------------------------------------------------------------------------------
-- Memory Stage.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( ByteOp :       in  STD_LOGIC;                       -- Control signal for choosing lw/sw (0) or lb/sb(1)
           Mem_WrEn :     in  STD_LOGIC;                       -- write enable memory
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);  -- ALU's Result flag for lb,sb,lw,sw from EX
           MEM_DataIn :   in  STD_LOGIC_VECTOR (31 downto 0);  -- RF[rd] result for swap, sb, sw ( from EX )
           MEM_DataOut :  out STD_LOGIC_VECTOR (31 downto 0);  -- data for lb,lw ( to RF )
           MM_Addr :      out STD_LOGIC_VECTOR (31 downto 0);  -- adress for module
           MM_WrEn :      out STD_LOGIC;                       -- write enable towards memory module
           MM_WrData :    out STD_LOGIC_VECTOR (31 downto 0);  -- data to be written in memory module
           MM_RdData :    in  STD_LOGIC_VECTOR (31 downto 0)); -- data read by memory module
end MEMSTAGE;

architecture Behavioral_MEMSTAGE of MEMSTAGE is
 
 signal tmp_MM_WrData :   std_logic_vector(31 downto 0);
 signal tmp_MEM_DataOut : std_logic_vector(31 downto 0);
 

begin
    process(MEM_DataIn, MM_RdData)
        begin 
                    
            if ByteOp = '0' then -- store/load word
                
                tmp_MM_WrData   <= MEM_DataIn; --sw
                tmp_MEM_DataOut <= MM_RdData;  --lw
                  
            else -- ByteOp = '1' -- store/load byte
                 
                tmp_MM_WrData(31 downto 8)   <= (others => '0');
                tmp_MM_WrData(7 downto 0)    <=  MEM_DataIn(7 downto 0); --sb
                tmp_MEM_DataOut(31 downto 8) <= (others => '0');
                tmp_MEM_DataOut(7 downto 0)  <= MM_RdData(7 downto 0); --lb
                
            end if; 
                         
    end process; 
    
    MM_Addr     <= ALU_MEM_Addr + x"00000400";
    MM_WrEn     <= Mem_WrEn; 
    MM_WrData   <= tmp_MM_WrData; 
    MEM_DataOut <= tmp_MEM_DataOut; 

                                                
end Behavioral_MEMSTAGE;


