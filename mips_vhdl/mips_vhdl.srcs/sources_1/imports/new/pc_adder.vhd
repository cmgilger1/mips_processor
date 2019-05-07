--------------------------------------------------------------------------------
-- adder.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    port ( pc : in std_logic_vector (31 downto 0);
           res : out std_logic_vector (31 downto 0);
           cout : out std_logic     
           );
end adder;

architecture Structural of adder is

    -- full adder component
    component full_adder
        port (  x   : in std_logic;
                y   : in std_logic;
                cin : in std_logic;
                sum : out std_logic;
                cout: out std_logic
            );
    end component;

    -- declare internal signals
    signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31 : std_logic;
    signal four : std_logic_vector (31 downto 0);
    
    
    begin
        -- hard-coded 4
        four <= "00000000000000000000000000000100";

        -- call full_adder 32 times (32 bit adder)
        c0 <= '0';
        adder0: full_adder port map (pc(0), four(0), c0, res(0), c1);
        adder1: full_adder port map (pc(1), four(1), c1, res(1), c2);
        adder2: full_adder port map (pc(2), four(2), c2, res(2), c3);
        adder3: full_adder port map (pc(3), four(3), c3, res(3), c4);
        adder4: full_adder port map (pc(4), four(4), c4, res(4), c5);
        adder5: full_adder port map (pc(5), four(5), c5, res(5), c6);
        adder6: full_adder port map (pc(6), four(6), c6, res(6), c7);
        adder7: full_adder port map (pc(7), four(7), c7, res(7), c8);
        adder8: full_adder port map (pc(8), four(8), c8, res(8), c9);
        adder9: full_adder port map (pc(9), four(9), c9, res(9), c10);
        adder10: full_adder port map (pc(10), four(10), c10, res(10), c11);
        adder11: full_adder port map (pc(11), four(11), c11, res(11), c12);
        adder12: full_adder port map (pc(12), four(12), c12, res(12), c13);
        adder13: full_adder port map (pc(13), four(13), c13, res(13), c14);
        adder14: full_adder port map (pc(14), four(14), c14, res(14), c15);
        adder15: full_adder port map (pc(15), four(15), c15, res(15), c16);
        adder16: full_adder port map (pc(16), four(16), c16, res(16), c17);
        adder17: full_adder port map (pc(17), four(17), c17, res(17), c18);
        adder18: full_adder port map (pc(18), four(18), c18, res(18), c19);
        adder19: full_adder port map (pc(19), four(19), c19, res(19), c20);
        adder20: full_adder port map (pc(20), four(20), c20, res(20), c21);
        adder21: full_adder port map (pc(21), four(21), c21, res(21), c22);
        adder22: full_adder port map (pc(22), four(22), c22, res(22), c23);
        adder23: full_adder port map (pc(23), four(23), c23, res(23), c24);
        adder24: full_adder port map (pc(24), four(24), c24, res(24), c25);
        adder25: full_adder port map (pc(25), four(25), c25, res(25), c26);
        adder26: full_adder port map (pc(26), four(26), c26, res(26), c27);
        adder27: full_adder port map (pc(27), four(27), c27, res(27), c28);
        adder28: full_adder port map (pc(28), four(28), c28, res(28), c29);
        adder29: full_adder port map (pc(29), four(29), c29, res(29), c30);
        adder30: full_adder port map (pc(30), four(30), c30, res(30), c31);
        adder31: full_adder port map (pc(31), four(31), c31, res(31), cout);

end Structural;
