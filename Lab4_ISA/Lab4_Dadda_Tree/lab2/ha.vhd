library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity ha is
  port (
    a: in std_logic;
    b: in std_logic;
    sum: out std_logic;
    c_out: out std_logic
    );
end ha;

architecture beh of ha is

begin  -- beh
  
  sum <= a XOR b;
  c_out <= a AND b;
 
end beh;
