--------------------------------------------------------------------------------
-- alu_control.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_control is
    port ( alu_op  : in std_logic_vector (1 downto 0);
           funct   : in std_logic_vector (5 downto 0);
           control : out std_logic_vector (3 downto 0)    
          );
end alu_control;

architecture Structural of alu_control is

    -- declare internal signal
    signal r_format : std_logic;

    begin
    
    -- r_format = 1 for r-type instructions
    r_format <= alu_op(1) and (not alu_op(0)); 
       
    process(alu_op, funct, r_format)
    
    begin
    
        case r_format is
    
            when '1' =>                 -- for r-format functs
                    
                control(3) <= '0';
                control(2) <= funct(5) and (not funct(2)) and funct(1);
                control(1) <= not funct(2);
                control(0) <= (funct(5) and (funct(4) or funct(3))) or (funct(2) and (funct(1) or funct(0))); 
    
            when others =>              -- for not r-format functs
    
                control(3) <= '0';
                control(2) <= funct(2) and (not funct(1)) and (not funct(0));
                control(1) <= (not funct(2)) or (funct(2) and (not funct(1)) and (not funct(0))); 
                control(0) <= funct(2) and (funct(1) or funct(0));
    
        end case;
    
    end process;

end Structural;
