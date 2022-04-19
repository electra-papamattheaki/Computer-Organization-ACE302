----------------------------------------------------------------------------------
-- Memory Stage Testbench. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_signed.all;
use  ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE_TB is
--  Port ( );
end MEMSTAGE_TB;

architecture Behavioral_MEMSTAGETB of MEMSTAGE_TB is

component MEMSTAGE
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

  -- Input Signals 
  signal ByteOp:       STD_LOGIC := '0';
  signal Mem_WrEn:     STD_LOGIC := '0';
  signal ALU_MEM_Addr: STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
  signal MEM_DataIn:   STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
  signal MM_RdData:    STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
  
  -- Output Singals
  signal MEM_DataOut:  STD_LOGIC_VECTOR (31 downto 0);
  signal MM_Addr:      STD_LOGIC_VECTOR (31 downto 0);
  signal MM_WrEn:      STD_LOGIC;
  signal MM_WrData:    STD_LOGIC_VECTOR (31 downto 0);
  
begin

  uut: MEMSTAGE port map ( ByteOp       => ByteOp,
                           Mem_WrEn     => Mem_WrEn,
                           ALU_MEM_Addr => ALU_MEM_Addr,
                           MEM_DataIn   => MEM_DataIn,
                           MEM_DataOut  => MEM_DataOut,
                           MM_Addr      => MM_Addr,
                           MM_WrEn      => MM_WrEn,
                           MM_WrData    => MM_WrData,
                           MM_RdData    => MM_RdData );

  stimulus: process
  begin
          
        -- hold reset state for 100 ns.
        wait for 100 ns;
      	
      			
        ByteOp       <= '0'; -- Word
        
        Mem_WrEn     <= '0'; --lw
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn   <= "00000000000001111111111111111111";
        MM_RdData    <= "00000000000001111111111111111111";
        wait for 100ns;
 
        Mem_WrEn     <= '0'; --lw
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn   <= "00000000000000111111000000000000";
        MM_RdData    <= "00000000000000111111000000000000";
        wait for 100ns; 
            
        Mem_WrEn     <= '1'; --sw
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn   <= "11111111111111111000000000000000";
        MM_RdData    <= "11111111111111111000000000000000";
        wait for 100ns;
      
        Mem_WrEn     <= '1'; --sw
        ALU_MEM_Addr <= "00000000000000000000000000000001";
        MEM_DataIn   <= "00000001111111111100000000000000";
        MM_RdData    <= "00000000000000111111000000000000";    
        wait for 100ns;
      
        ByteOp       <= '1'; -- Byte
        
        Mem_WrEn     <= '0'; --lb
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn   <= "11111111111111111111111111111111";
        MM_RdData    <= "00000000000000111111000000000000";
        wait for 100ns;
      
        Mem_WrEn     <= '0'; --lb
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn   <= "00000001111111111111111111111111";
        MM_RdData    <= "00000011111000111111000000000000";
        wait for 100ns;
         
        Mem_WrEn     <= '1'; --sb
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn   <= "11111111111111111111111111111111";
        MM_RdData    <= "00000000000000111111000111100000";
        wait for 100ns;
      
        Mem_WrEn     <= '1'; --sb
        ALU_MEM_Addr <= "00000000000000000000000000010001";
        MEM_DataIn   <= "11111111111111111111111000000000";
        MM_RdData    <= "00000000000000111111111100000000";
        wait for 100ns;
      			     
    wait;
  end process;


end Behavioral_MEMSTAGETB;
