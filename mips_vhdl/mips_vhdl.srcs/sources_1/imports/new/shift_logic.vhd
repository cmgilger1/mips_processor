--------------------------------------------------------------------------------
-- shift_logic.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_logic is
  Port ( 
        val_a :  in std_logic_vector (31 downto 0);
        val_b : out std_logic_vector (31 downto 0)
  );
end shift_logic;

architecture Behavorial of shift_logic is


begin

    process(val_a)
    begin 
        val_b <= std_logic_vector(shift_left(unsigned(val_a), 2));
    end process;


end Behavorial;