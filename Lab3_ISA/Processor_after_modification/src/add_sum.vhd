library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity add_sum is
  port (
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    sum: out std_logic_vector(31 downto 0)
    );
end add_sum;

architecture beh of add_sum is

begin  -- beh

process(a,b)
  variable av: integer;
  variable bv: integer;
begin
  av := to_integer(unsigned(a));
  bv := to_integer(unsigned(b));

  sum <= std_logic_vector(to_unsigned(av+bv, sum'length)); 
end process;
end beh;