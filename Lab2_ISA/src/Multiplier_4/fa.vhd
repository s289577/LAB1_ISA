library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity fa is
  port (
    c_in: in std_logic;
    a: in std_logic;
    b: in std_logic;
    sum: out std_logic;
    c_out: out std_logic
    );
end fa;

architecture beh of fa is

begin  -- beh  bnhgv
  
  sum <= (a XOR b) XOR c_in;
  c_out <= (c_in AND (A XOR B)) OR (a AND b); -- c_out <= (a AND b) OR (b AND c_in) OR (c_in AND a);
 
end beh;
