--------------------------------------------------------------------------------
-- execute.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity execute is
    port (  in_a  : in std_logic_vector (31 downto 0);
            in_b  : in std_logic_vector (31 downto 0);
            op    : in std_logic_vector (3 downto 0);
            out_z : out std_logic_vector (31 downto 0);
            carry : out std_logic;
            zero  : out std_logic;
            over  : out std_logic
        );
end execute;

architecture Structural of execute is

    component project_adder
        port (  val_a : in std_logic_vector (31 downto 0);
                val_b : in std_logic_vector (31 downto 0);
                res   : out std_logic_vector (31 downto 0);
                cout  : out std_logic     
            );
    end component;

    -- declare internal siganals
    signal a_ext    : signed(32 downto 0);
    signal b_ext    : signed(32 downto 0);
    signal add_out  : std_logic_vector(32 downto 0);
    signal sub_out  : std_logic_vector(32 downto 0);
    signal less31   : std_logic_vector(30 downto 0);
    signal setless  : std_logic_vector(31 downto 0);
    signal sig_out  : std_logic_vector(31 downto 0);

    begin

        -- initialize internal signals
        less31 <= "0000000000000000000000000000000";
        a_ext <= signed(in_a(31) & in_a);
        b_ext <= signed(in_b(31) & in_b);
        add_out <= std_logic_vector(a_ext + b_ext);
        sub_out <= std_logic_vector(a_ext - b_ext);
        setless <= less31 & sub_out(31);

        -- based on op vector, set outputs accordingly
        process(in_a, in_b, add_out, sub_out, op, setless, sig_out)
        begin

            case op is 
                
                when "0000" =>                  -- and
                
                    sig_out <= in_a and in_b;
                    carry <= '0';
                    over  <= '0';

                when "0001" =>                  -- or    
                
                    sig_out <= in_a or in_b;
                    carry <= '0';
                    over  <= '0';

                when "0010" =>                  -- add
                
                    sig_out <= add_out(31 downto 0);
                    carry <= add_out(32);
                
                    -- determine overflow
                    if ((signed(in_a) >= 0) and (signed(in_b) >= 0) and (signed(sig_out) < 0)) then
                        over <= '1';
                    elsif (signed(in_a) < 0) and (signed(in_b) < 0) and (signed(sig_out) >= 0) then
                        over <= '1';
                    else
                        over <= '0';
                    end if;
                    
                when "0110" =>                  -- subtract
                
                    sig_out <= sub_out(31 downto 0);
                    carry <= sub_out(32);
                
                    -- determine overflow
                    if ((signed(in_a) >= 0) and (signed(in_b) < 0) and (signed(sig_out) < 0)) then
                        over <= '1';
                    elsif (signed(in_a) < 0) and (signed(in_b) >= 0) and (signed(sig_out) >= 0) then
                        over <= '1';
                    else
                        over <= '0';
                    end if;

                when "0111" =>                  -- slt if a < b
                    
                    sig_out <= setless; 
                    carry <= sub_out(32);
                    
                    -- determine overflow
                    if ((signed(in_a) >= 0) and (signed(in_b) < 0) and (signed(sig_out) < 0)) then
                        over <= '1';
                    elsif (signed(in_a) < 0) and (signed(in_b) >= 0) and (signed(sig_out) >= 0) then
                        over <= '1';
                    else
                        over <= '0';
                    end if;

                when others =>            
                    NULL;

            end case;
            
            -- zero flag
            if (sig_out = x"00000000") then
            
                zero <= '1';
            
            else 
            
               zero <= '0';
            
            end if;

            out_z <= sig_out;
            
        end process;


end Structural;
