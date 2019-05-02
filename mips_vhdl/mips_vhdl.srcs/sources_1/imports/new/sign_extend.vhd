--------------------------------------------------------------------------------
-- sign_extend.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sign_extend is
    port ( port_in  : in std_logic_vector(15 downto 0);
           port_out : out std_logic_vector(31 downto 0)
        );
end sign_extend;

architecture Behavioral of sign_extend is

begin

    port_out <= port_in(15) & port_in(15) & port_in(15) & port_in(15) & 
                port_in(15) & port_in(15) & port_in(15) & port_in(15) & 
                port_in(15) & port_in(15) & port_in(15) & port_in(15) & 
                port_in(15) & port_in(15) & port_in(15) & port_in(15) & 
                port_in(15 downto 0);   

end Behavioral;
