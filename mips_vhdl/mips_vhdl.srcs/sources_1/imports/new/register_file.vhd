--------------------------------------------------------------------------------
-- register_file.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
    port ( r_addr1  : in std_logic_vector (4 downto 0);
           r_addr2  : in std_logic_vector (4 downto 0);
           w_addr   : in std_logic_vector (4 downto 0);
           w_data   : in std_logic_vector (31 downto 0);
           clk      : in std_logic;
           w_en     : in std_logic;
           r_data1  : out std_logic_vector (31 downto 0);
           r_data2  : out std_logic_vector (31 downto 0)
        );
end register_file;

architecture Behavioral of register_file is

-- set up register file array
type regFile is array (0 to 31) of std_logic_vector (31 downto 0);
signal regs : regFile := (
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000", x"00000000", x"00000000"
    );

begin
    -- determine if rising edge of clock and read/write data
    process (clk, w_en, w_addr, r_addr1, r_addr2, w_data)
    begin 
        if clk'event and clk='0' then
            if (w_en = '1') then
                regs(to_integer(unsigned(w_addr))) <= w_data; 
            end if;
        end if;
            r_data1 <= regs(to_integer(unsigned(r_addr1)));
            r_data2 <= regs(to_integer(unsigned(r_addr2)));
    end process;

end Behavioral;
