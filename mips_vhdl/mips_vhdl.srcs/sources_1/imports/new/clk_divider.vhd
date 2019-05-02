--------------------------------------------------------------------------------
-- clk_divider.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_divider is
	port (	clk_in  : in std_logic;
    		clk_out : out std_logic
  			);
end clk_divider;

architecture Behavioral of clk_divider is

constant TIMECONST : integer := 32;
signal count0, count1, count2, count3 : integer range 0 to 1000;
signal D : std_logic := '1';

begin

process (clk_in, D) 
begin
	if (clk_in'event and clk_in = '1') then
		count0 <= count0 + 1;
		if count0 = TIMECONST then
			count0 <= 0;
			count1 <= count1 + 1;
		elsif count1 = TIMECONST then
			count1 <= 0;
			count2 <= count2 + 1;
		elsif count2 = TIMECONST then
			count2 <= 0;
			count3 <= count3 + 1;
		elsif count3 = TIMECONST then
			count3 <= 0;
			D <= not D;
		end if;
	end if;
	clk_out <= D;
end process;

end Behavioral;
