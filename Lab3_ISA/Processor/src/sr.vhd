library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sr is
  port (
    s: in std_logic;
    r: in std_logic;
    q: out std_logic);
end sr;

architecture beh of sr is
  signal not_q: std_logic;
  signal q_tmp: std_logic;
begin
  q_tmp <= r nor not_q;
  not_q <= s nor q_tmp;

  q <= q_tmp;

end beh;
