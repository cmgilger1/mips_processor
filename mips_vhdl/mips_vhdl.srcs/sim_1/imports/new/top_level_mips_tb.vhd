--------------------------------------------------------------------------------
-- Title: top_level_mips_tb.vhd
-- By: Caroline Gilger, Andrew Laurita, Nathan Keyes
-- Description: This is a testbench for the top level mips controller.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--------------------------------------------------------------------------------
-- Declaration
--------------------------------------------------------------------------------
entity top_level_mips_tb is
end top_level_mips_tb;

--------------------------------------------------------------------------------
-- Description
--------------------------------------------------------------------------------
architecture Behavioral of top_level_mips_tb is

-- top level component
component top_level_mips is
    port( ck   : in std_logic;
          out_led : out std_logic_vector(15 downto 0)
          );
end component;

-- initialize UUT
for uut: top_level_mips use entity work.top_level_mips(Structural);

-- declare and initialize signals/variables
signal result : std_logic_vector(15 downto 0);
signal clk    : std_logic := '0';
constant clk_period : time := 10ns;


begin
    
    -- port map top level component
    uut: top_level_mips port map(clk, result);
    
    -- start clock
    process
    begin
        clk <= not clk;
        wait for clk_period/2;
    end process;
    
    process
    begin
        wait;

    end process;

end Behavioral;
