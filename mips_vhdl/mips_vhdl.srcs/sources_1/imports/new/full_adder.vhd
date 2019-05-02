--------------------------------------------------------------------------------
-- Title: full_adder.vhd
-- By: Caroline Gilger, Andrew Laurita, Nathan Keyes
-- Description: This program takes in inputs x, y, and cin to add and produce 
--              outputs sum and cout. 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------------------------------------------------------
-- Declaration
--------------------------------------------------------------------------------
entity full_adder is
    port( x   : in std_logic;
          y   : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          cout: out std_logic
        );
end full_adder;

--------------------------------------------------------------------------------
-- Description
--------------------------------------------------------------------------------
architecture my_dataflow of full_adder is

begin

    -- give values for output signals
    sum <= (x xor y) xor cin;
    cout  <= (x and y) or (x and cin) or (y and cin);

end my_dataflow;

