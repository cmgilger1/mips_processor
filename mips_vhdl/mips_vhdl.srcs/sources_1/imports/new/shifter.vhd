--------------------------------------------------------------------------------
-- shifter.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shifter is
    port ( ctl    : in std_logic_vector (5 downto 0);
           shift  : in std_logic_vector (4 downto 0);
           in_sh  : in std_logic_vector (31 downto 0);
           out_sh : out std_logic_vector (31 downto 0)
          );
end shifter;

architecture Structural of shifter is

begin
    
    process (ctl, in_sh, shift)
   
    begin
   
        case ctl is 
   
            when "000000" =>                -- for sll funct
   
                out_sh <= std_logic_vector(shift_left(unsigned(in_sh), to_integer(unsigned(shift))));
                    
            when "000010" =>                -- for srl funct
   
                out_sh <= std_logic_vector(shift_right(unsigned(in_sh), to_integer(unsigned(shift))));
            
            when "001111" =>                -- for lui funct
   
                out_sh <= std_logic_vector(shift_left(unsigned(in_sh), 16));
            
            when others =>                  
   
                NULL;
                
        end case;
    
    end process;

end Structural;
