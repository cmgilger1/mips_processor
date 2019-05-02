--------------------------------------------------------------------------------
-- mux3.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux3 is
    port (  switch : in std_logic_vector (1 downto 0);
            in1 : in std_logic_vector (31 downto 0);
            in2 : in std_logic_vector (31 downto 0);
            in3 : in std_logic_vector (31 downto 0);
            out1 : out std_logic_vector (31 downto 0)		   
            );
end mux3;

architecture Behavioral of mux3 is    
    
begin

    process (switch, in1, in2, in3)
    begin

        case switch is
            when "00" => out1 <= in1;
            when "01" => out1 <= in2;
            when others => out1 <= in3;
        end case;

    end process;
	
end Behavioral;
