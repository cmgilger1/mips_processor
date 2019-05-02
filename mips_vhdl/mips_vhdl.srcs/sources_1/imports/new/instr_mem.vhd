--------------------------------------------------------------------------------
-- instr_mem.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instr_mem is
    port ( in_addr  : in std_logic_vector (31 downto 0);
           out_instr : out std_logic_vector (31 downto 0)
        );
end instr_mem;

architecture Behavioral of instr_mem is

type program is array (0 to 15) of std_logic_vector (31 downto 0);
signal instr : program := (
    "10001100000010010000000000000000", --lw $t1, 0($zero)  
    "10001100000010100000000000000001", --lw $t2, 1($zero)  
    "10001100000010110000000000000011", --lw $t3, 3($zero)  
    "00000001001010100110000000100000", --add $t4, $t1, $t2 
    "00000001001010100110100000100000", --add $t5, $t1, $t2 
    "00010001011011000000000000000010", --beq $t3, $t4, 2   
    "00000001011011000110100000100000", --add $t5, $t3, $t4 
    "10101100000011010000000000000100", --sw $t5, 4($zero)  
    "10001100000011100000000000000100", --lw $t6, 4($zero)  
    "10001100000011100000000000000100", -- done 
    "10001100000011100000000000000100", -- spam the rest
    "10001100000011100000000000000100", -- of the instructions
    "10001100000011100000000000000100", -- with the last
    "10001100000011100000000000000100", -- instruction
    "10001100000011100000000000000100", -- so that the LEDs
    "10001100000011100000000000000100"  -- stay on
    );

begin

    out_instr <= instr(to_integer(unsigned(in_addr))/4);


end Behavioral;
