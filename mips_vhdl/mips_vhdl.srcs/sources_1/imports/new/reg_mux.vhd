--------------------------------------------------------------------------------
-- reg_mux.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_mux is
    port (  switch : in std_logic_vector (1 downto 0);
            in1    : in std_logic_vector (4 downto 0);
            in2    : in std_logic_vector (4 downto 0);
            in3    : in std_logic_vector (4 downto 0);
            out1   : out std_logic_vector (4 downto 0)		   
            );
end reg_mux;

architecture Behavioral of reg_mux is    
    
    begin
        process(switch, in1, in2, in3)
        begin
        case switch is
            when "00" => 
                out1 <= in1;
            when "01" => 
                out1 <= in2;
            when "10" => 
                out1 <= in3;
            when others =>
                out1 <= "00000";
        end case;
    end process;	
end Behavioral;
