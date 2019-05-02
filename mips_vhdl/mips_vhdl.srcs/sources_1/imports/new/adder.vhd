--------------------------------------------------------------------------------
-- adder.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    port (  val_a : in std_logic_vector (31 downto 0);
            val_b : in std_logic_vector (31 downto 0);
            res : out std_logic_vector (31 downto 0);
            cout : out std_logic     
            );
end adder;

architecture Structural of adder is

    component full_adder
        port (  x   : in std_logic;
                y   : in std_logic;
                cin : in std_logic;
                sum : out std_logic;
                cout: out std_logic
            );
    end component;

    signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31 : STD_LOGIC;
    
    begin
    
        c0 <= '0';
        adder0: full_adder port map (val_a(0), val_b(0), c0, res(0), c1);
        adder1: full_adder port map (val_a(1), val_b(1), c1, res(1), c2);
        adder2: full_adder port map (val_a(2), val_b(2), c2, res(2), c3);
        adder3: full_adder port map (val_a(3), val_b(3), c3, res(3), c4);
        adder4: full_adder port map (val_a(4), val_b(4), c4, res(4), c5);
        adder5: full_adder port map (val_a(5), val_b(5), c5, res(5), c6);
        adder6: full_adder port map (val_a(6), val_b(6), c6, res(6), c7);
        adder7: full_adder port map (val_a(7), val_b(7), c7, res(7), c8);
        adder8: full_adder port map (val_a(8), val_b(8), c8, res(8), c9);
        adder9: full_adder port map (val_a(9), val_b(9), c9, res(9), c10);
        adder10: full_adder port map (val_a(10), val_b(10), c10, res(10), c11);
        adder11: full_adder port map (val_a(11), val_b(11), c11, res(11), c12);
        adder12: full_adder port map (val_a(12), val_b(12), c12, res(12), c13);
        adder13: full_adder port map (val_a(13), val_b(13), c13, res(13), c14);
        adder14: full_adder port map (val_a(14), val_b(14), c14, res(14), c15);
        adder15: full_adder port map (val_a(15), val_b(15), c15, res(15), c16);
        adder16: full_adder port map (val_a(16), val_b(16), c16, res(16), c17);
        adder17: full_adder port map (val_a(17), val_b(17), c17, res(17), c18);
        adder18: full_adder port map (val_a(18), val_b(18), c18, res(18), c19);
        adder19: full_adder port map (val_a(19), val_b(19), c19, res(19), c20);
        adder20: full_adder port map (val_a(20), val_b(20), c20, res(20), c21);
        adder21: full_adder port map (val_a(21), val_b(21), c21, res(21), c22);
        adder22: full_adder port map (val_a(22), val_b(22), c22, res(22), c23);
        adder23: full_adder port map (val_a(23), val_b(23), c23, res(23), c24);
        adder24: full_adder port map (val_a(24), val_b(24), c24, res(24), c25);
        adder25: full_adder port map (val_a(25), val_b(25), c25, res(25), c26);
        adder26: full_adder port map (val_a(26), val_b(26), c26, res(26), c27);
        adder27: full_adder port map (val_a(27), val_b(27), c27, res(27), c28);
        adder28: full_adder port map (val_a(28), val_b(28), c28, res(28), c29);
        adder29: full_adder port map (val_a(29), val_b(29), c29, res(29), c30);
        adder30: full_adder port map (val_a(30), val_b(30), c30, res(30), c31);
        adder31: full_adder port map (val_a(31), val_b(31), c31, res(31), cout);

end Structural;
