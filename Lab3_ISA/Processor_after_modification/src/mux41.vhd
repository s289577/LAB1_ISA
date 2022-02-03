library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity mux41 is
  port (
    s : in std_logic_vector(1 downto 0); 
    a : in std_logic_vector(31 downto 0);
    b : in std_logic_vector(31 downto 0);
    c : in std_logic_vector(31 downto 0);
    d : in std_logic_vector(31 downto 0);
    e : out std_logic_vector(31 downto 0)
  );
end mux41;

architecture beh of mux41 is

begin  -- beh
  
  e <= a when s = "00" else
      b when s = "01" else
      c when s = "11" else
      d;
     -- d when s = "10";
end beh;