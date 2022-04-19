----------------------------------------------------------------------------------
-- Checking the proper usage of RAM. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_signed.all;
use  ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_tb is
--  empty entity;
end RAM_tb;

architecture ram_bench of RAM_tb is

component RAM
      port ( clk :       in  std_logic;
             inst_addr : in  std_logic_vector(10 downto 0);
             inst_dout : out std_logic_vector(31 downto 0);
             data_we :   in  std_logic;
             data_addr : in  std_logic_vector(10 downto 0);
             data_din :  in  std_logic_vector(31 downto 0);
             data_dout : out std_logic_vector(31 downto 0));
   end component;

  signal clk:       std_logic := '0';
  signal inst_addr: std_logic_vector(10 downto 0) := "00000000000";
  signal inst_dout: std_logic_vector(31 downto 0) := X"00000000";
  signal data_we:   std_logic := '0';
  signal data_addr: std_logic_vector(10 downto 0) := "00000000000";
  signal data_din:  std_logic_vector(31 downto 0) := X"00000000";
  signal data_dout: std_logic_vector(31 downto 0) := X"00000000";

  constant clock_period: time := 100 ns;
  
begin

  uut: RAM port map ( clk       => clk,         -- Clock
                      inst_addr => inst_addr,   -- Address of instruction
                      inst_dout => inst_dout,   -- Instruction read by memory
                      data_we   => data_we,     -- Write Enable Flag
                      data_addr => data_addr,   -- Address for reading/writing data
                      data_din  => data_din,    -- Data written in memory
                      data_dout => data_dout ); -- Data read by memory

  stimulus: process
  begin
  
    wait for 5ns; -- hold for 100ns
         
    for i in 0 to 255 loop
        data_we <= '1'; -- always enable ram
        wait for 5ns; 
        data_addr <= data_addr + 1; 
        data_din  <= data_din + 10; 
    end loop;
    
    data_addr <= "00000000000";
    
    for i in 0 to 255 loop
        data_we <= '0'; -- read mode
        wait for 5 ns;
        data_addr <= data_addr + 1;
    end loop;
       
    wait;
  end process;

  clocking: process
    begin
	   Clk <= '0';
	   wait for clock_period/2;
	   Clk <= '1';
	   wait for clock_period/2;
  end process;

end ram_bench;
