--------------------------------------------------------------------------------
-- pc_buffer
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc_buffer is
    port ( in_pc : in std_logic_vector (31 downto 0);
           clk   : in std_logic;
           out_pc: out std_logic_vector (31 downto 0)
        );
end pc_buffer;

architecture Behavioral of pc_buffer is

signal addr : std_logic_vector(31 downto 0) := x"00000000";

begin

    process (clk)
    begin
        out_pc <= addr;
        if (clk = '0' and clk'event) then
            addr <= in_pc;
        end if;
    end process;


end Behavioral;
