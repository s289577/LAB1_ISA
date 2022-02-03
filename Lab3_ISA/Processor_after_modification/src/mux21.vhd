library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity mux21 is
  port (
    s : in std_logic; 
    a : in std_logic_vector(31 downto 0);
    b : in std_logic_vector(31 downto 0);
    c : out std_logic_vector(31 downto 0)
  );
end mux21;

architecture beh of mux21 is

begin  -- beh
  
  c <= a when s = '0' else
       b when s = '1';
end beh;