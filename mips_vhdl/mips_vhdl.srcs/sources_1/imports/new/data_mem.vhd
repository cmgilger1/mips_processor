--------------------------------------------------------------------------------
-- data_mem.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_mem is
    port (  in_addr  : in std_logic_vector (31 downto 0);
            in_data  : in std_logic_vector (31 downto 0);
            writeEn  : in std_logic;
            readEn   : in std_logic;
            clock    : in std_logic;
            out_data : out std_logic_vector (31 downto 0)
            );
end data_mem;

architecture Behavioral of data_mem is

type memUnit is array (0 to 63) of std_logic_vector (31 downto 0);
signal data : memUnit := (
    x"00000004", x"00000004", x"DEADBEEF", x"00000008", -- 0x00
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x04
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x08
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x0C
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x0F
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x14
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x18
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x1C
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x1F
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x20
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x24
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x28
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x2C
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x2F
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", -- 0x30
    x"DEADBEEF", x"DEADBEEF", x"DEADBEEF", x"DEADBEEF"  -- 0x34
    );

begin

    process (clock, writeEn, readEn, in_addr, in_data)
    begin
    
        -- for writing 
        if (writeEn = '1') then
            if clock'event and clock='1' then
                data(to_integer(unsigned(in_addr))) <= in_data; 
            end if;
        end if;

        -- for reading
        if (readEn = '1') then
            out_data <= data(to_integer(unsigned(in_addr)));
        end if;

    end process;

end Behavioral;
