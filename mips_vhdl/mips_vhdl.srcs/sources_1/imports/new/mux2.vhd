--------------------------------------------------------------------------------
-- mux2.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    port (  switch : in std_logic;
            in1    : in std_logic_vector (31 downto 0);
            in2    : in std_logic_vector (31 downto 0);
            out1   : out std_logic_vector (31 downto 0)	   
            );
end mux2;

architecture Behavioral of mux2 is    
    
begin
	process (switch, in1, in2)
    begin

        case switch is
            when "0" => out1 <= in1;
            when others => out1 <= in2;
        end case;

    end process;
	
end Behavioral;
