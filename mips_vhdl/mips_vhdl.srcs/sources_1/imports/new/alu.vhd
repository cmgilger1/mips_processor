--------------------------------------------------------------------------------
-- alu.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port ( control    : in std_logic_vector (1 downto 0);
           a          : in std_logic_vector (31 downto 0);
           b          : in std_logic_vector (31 downto 0);
           funct      : in std_logic_vector (5 downto 0);
           shamt      : in std_logic_vector (4 downto 0);
           result     : out std_logic_vector (31 downto 0);
           oflow      : out std_logic;
           zflag      : out std_logic;
           cout       : out std_logic
          );
end alu;

architecture Structural of alu is

    component alu_control
        port ( alu_op  : in std_logic_vector (1 downto 0);
               funct   : in std_logic_vector (5 downto 0);
               control : out std_logic_vector (3 downto 0)
               );
    end component;

    component execute is
        port (  in_a  : in std_logic_vector (31 downto 0);
                in_b  : in std_logic_vector (31 downto 0);
                op    : in std_logic_vector (3 downto 0);
                out_z : out std_logic_vector (31 downto 0);
                carry : out std_logic;
                zero  : out std_logic;
                over  : out std_logic
              );
    end component;   
    
    component shifter is
        port ( ctl    : in std_logic_vector (5 downto 0);
               shift  : in std_logic_vector (4 downto 0);
               in_sh  : in std_logic_vector (31 downto 0);
               out_sh : out std_logic_vector (31 downto 0)
              );
    end component; 
    
    component sel is
        port ( f    : in std_logic_vector(5 downto 0);
               res0 : in std_logic_vector(31 downto 0);
               res1 : in std_logic_vector(31 downto 0);
               final: out std_logic_vector(31 downto 0)
              );
    end component;       

    -- declare internal signals
    signal alu_cont    : std_logic_vector (3 downto 0);    
    signal mux0_result : std_logic_vector (31 downto 0);
    signal mux1_result : std_logic_vector (31 downto 0);
    
    begin
        
        controller: alu_control port map(control, funct, alu_cont);

        shiftme: shifter port map(funct, shamt, a, mux1_result);
        
        solve: execute port map(a, b, alu_cont, mux0_result, cout, zflag, oflow);

        res_sel: sel port map(funct, mux0_result, mux1_result, result);


end Structural;
