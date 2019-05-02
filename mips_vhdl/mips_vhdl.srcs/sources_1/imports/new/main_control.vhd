--------------------------------------------------------------------------------
-- main_control.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_control is
  Port ( instr      : in std_logic_vector(5 downto 0);
         funct      : in std_logic_vector(5 downto 0);
         regDst     : out std_logic_vector(1 downto 0);
         branch     : out std_logic;
         memRead    : out std_logic;
         memToReg   : out std_logic_vector(1 downto 0);
         aluOp      : out std_logic_vector(1 downto 0);
         memWrite   : out std_logic;
         aluSrc     : out std_logic;
         regWrite   : out std_logic;
         jump       : out std_logic_vector(1 downto 0)
        );
end main_control;

architecture Behavioral of main_control is

    -- declare internal instruction signals
    signal r_type : std_logic;
    signal lw     : std_logic;
    signal sw     : std_logic;
    signal beq    : std_logic;
    signal addi   : std_logic;
    signal ori    : std_logic;
    signal lui    : std_logic;
    signal jal    : std_logic;
    signal jr     : std_logic;

    -- initialize instruction signals
    begin
        -- "000000"
        r_type <= ((not instr(5)) and (not instr(4)) and (not instr(3)) and (not instr(2)) and (not instr(1)) and (not instr(0)));
        -- "100011"
        lw <= (instr(5) and (not instr(4)) and (not instr(3)) and (not instr(2)) and instr(1) and instr(0));
        -- "101011"
        sw <= (instr(5) and (not instr(4)) and instr(3) and (not instr(2)) and instr(1) and instr(0));
        -- "000100"
        beq <= ((not instr(5)) and (not instr(4)) and (not instr(3)) and instr(2) and (not instr(1)) and (not instr(0)));
        -- "001000"
        addi <= ((not instr(5)) and (not instr(4)) and instr(3) and (not instr(2)) and (not instr(1)) and (not instr(0)));
        -- "001101"
        ori <= ((not instr(5)) and (not instr(4)) and instr(3) and instr(2) and (not instr(1)) and instr(0));
        -- "001111"
        lui <= ((not instr(5)) and (not instr(4)) and instr(3) and instr(2) and instr(1) and instr(0));
        -- "000011"
        jal <= ((not instr(5)) and (not instr(4)) and (not instr(3)) and (not instr(2)) and instr(1) and instr(0));
        -- "000000"
        jr <= ((not instr(5)) and (not instr(4)) and (not instr(3)) and (not instr(2)) and (not instr(1)) and (not instr(0)));

        -- initialize control signals
        regDst(0) <= r_type;
        regDst(1) <= jal;
        aluSrc <= addi or lw or sw or ori or lui;
        memToReg(0) <= (not lw) and (not jal);
        memToReg(1) <= jal;
        memRead <= lw;
        memWrite <= sw;
        branch <= beq;
        aluOp(0) <= beq or lui;
        aluOp(1) <= r_type or lui;

        -- differentiate between jr and other r-types
        process(funct, instr, jal, jr, r_type, lw, ori, lui, addi) 
        
        begin
        
            case instr is
        
                when "000000" =>                        -- for r-types
        
                    case funct is
        
                        when "001000" =>                -- for jr instruction
        
                            jump(0) <= '0';
                            jump(1) <= jr;
                            regWrite <= '0';
        
                        when others =>                  -- for not jr instructions
        
                            jump(0) <= not jal;
                            jump(1) <= '0';
                            regWrite <= addi or r_type or lw or ori or jal or lui;  
        
                    end case;
        
                when others =>                          -- for not r-types
                    jump(0) <= not jal;
                    jump(1) <= jr;
                    regWrite <= addi or r_type or lw or ori or jal or lui;        
        
            end case;
        
        end process;

end Behavioral;
