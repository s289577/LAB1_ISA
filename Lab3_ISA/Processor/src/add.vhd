library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity add is
  port (
    a: in std_logic_vector(31 downto 0);
    sum: out std_logic_vector(31 downto 0)
    );
end add;

architecture beh of add is
  constant bv: integer:= 4;

begin  -- beh
  process(a)
    variable av: integer;
    
  begin
    av := to_integer(unsigned(a));
    sum <= std_logic_vector(to_unsigned(av+bv, sum'length));
  end process;

end beh;
