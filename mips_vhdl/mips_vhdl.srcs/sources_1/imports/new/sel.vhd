--------------------------------------------------------------------------------
-- sel.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sel is
    port (  f    : in std_logic_vector(5 downto 0);
            res0 : in std_logic_vector(31 downto 0);
            res1 : in std_logic_vector(31 downto 0);
            final: out std_logic_vector(31 downto 0)
            );
end sel;

architecture Structural of sel is

begin
    
    process(f, res0, res1)
        
    begin
    
        case f is 
            when "000000" =>        -- sll shifter output
                final <= res1;
        
            when "000010" =>        -- srl shifter output
                final <= res1;
            
            when "001111" =>        -- lui shifter output
                final <= res1;
                
            when others =>
                final <= res0;
        
        end case;
        
    end process;

end Structural;
