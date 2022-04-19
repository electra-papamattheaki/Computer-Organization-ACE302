----------------------------------------------------------------------------------
-- A Processing Unit that takes a 16-bit immediate input and converts it to 
-- a 32-bit output with shift or zero-filling or sign-extension. 
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

-- ImmedExt: 00 -> ZeroFill | 01 -> <<16 ZeroFill | 10 -> SignExtend | 11 -> <<SingExtend
entity ProcessingUnit is
    Port ( ImmedExt :  in STD_LOGIC_VECTOR (1 downto 0);
           --opcode :    in  STD_LOGIC_VECTOR (5 downto 0);
           unit_in :   in  STD_LOGIC_VECTOR (15 downto 0);
           unit_out :  out STD_LOGIC_VECTOR (31 downto 0));
end ProcessingUnit;

architecture Behavioral_ProcessingUnit of ProcessingUnit is

signal signExt :      std_logic_vector (15 downto 0);
signal signExtShift : std_logic_vector (13 downto 0);

begin

    with unit_in(15) select
	signExt <= "0000000000000000" when '0',
			   "1111111111111111" when others;
    
    with unit_in(15) select
	signExtShift <= "00000000000000" when '0',
			        "11111111111111" when others;
	
	ImmediateExtend : process(unit_in, ImmedExt)
        begin
            case ImmedExt is
    
                -- ZeroFill
                when "00" => 
                    unit_out(31 downto 16) <= "0000000000000000"; 
                    unit_out(15 downto 0)  <= unit_in;		        
                -- <<16 ZeroFill
                when "01" => 
                    unit_out(31 downto 16) <= unit_in;
                    unit_out(15 downto 0)  <= "0000000000000000";
                -- SignExtend
                when "10" => 
                    unit_out(31 downto 16) <= signExt;
                    unit_out(15 downto 0)  <= unit_in;                    
                -- <<2 SignExtend                 
                when "11" => -- b
                    unit_out(31 downto 18) <= signExtShift;
                    unit_out(17 downto 2)  <= unit_in;
                    unit_out(1 downto 0)   <= "00"; 
                when others =>    
                    unit_out <= X"00000000";               
             end case;
        end process;                   
                    
--    ImmediateExtend : process(unit_in, opcode)
--        begin
--            case opcode is
    
--                -- ZeroFill
--                when "110010" => -- nandi
--                    unit_out(31 downto 16) <= "0000000000000000"; 
--                    unit_out(15 downto 0)  <= unit_in;
--                when "110011" => -- ori
--                    unit_out(31 downto 16) <= "0000000000000000"; 
--                    unit_out(15 downto 0)  <= unit_in;
--                -- <<16 ZeroFill
--                when "111001" => -- lui
--                    unit_out(31 downto 16) <= unit_in;
--                    unit_out(15 downto 0)  <= "0000000000000000";
--                -- Sign Extend
--                when "110000" => -- addi
--                    unit_out(31 downto 16) <= signExt;
--                    unit_out(15 downto 0)  <= unit_in;
--                when "111000" => -- li
--                    unit_out(31 downto 16) <= signExt;
--                    unit_out(15 downto 0)  <= unit_in;
--                when "000011" => -- lb
--                    unit_out(31 downto 16) <= signExt;
--                    unit_out(15 downto 0)  <= unit_in;
--                when "000111" => -- sb
--                    unit_out(31 downto 16) <= signExt;
--                    unit_out(15 downto 0)  <= unit_in;
--                when "001111" => -- lw
--                    unit_out(31 downto 16) <= signExt;
--                    unit_out(15 downto 0)  <= unit_in;
--                when "011111" => -- sw
--                    unit_out(31 downto 16) <= signExt;
--                    unit_out(15 downto 0)  <= unit_in;
--                -- << 2 Sign Extend
--                when "111111" => -- b
--                    unit_out(31 downto 18) <= signExtShift;
--                    unit_out(17 downto 2)  <= unit_in;
--                    unit_out(1 downto 0)   <= "00";
--                when "000000" => -- beq
--                    unit_out(31 downto 18) <= signExtShift;
--                    unit_out(17 downto 2)  <= unit_in;
--                    unit_out(1 downto 0)   <= "00";
--                when "000001" => -- bne
--                    unit_out(31 downto 18) <= signExtShift;
--                    unit_out(17 downto 2)  <= unit_in;
--                    unit_out(1 downto 0)   <= "00";
--                 when others =>
--                    unit_out <= X"00000000";
--            end case;
--        end process;

end Behavioral_ProcessingUnit;
