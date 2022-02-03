library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity instruction_memory is
  port (
    address: in std_logic_vector(31 downto 0);
    instruction: out std_logic_vector(31 downto 0)
    );
end instruction_memory;

architecture beh of instruction_memory is

begin  -- beh

process(address)
begin 
  case address is
    when x"00400000" => instruction <= x"01100093"; --LI
    when x"00400004" => instruction <= x"FEF00113"; --LI
    when x"00400008" => instruction <= x"000081FF"; --ABS
    when x"0040000c" => instruction <= x"0001027F"; --ABS

    when others => instruction <= x"00000000";

  end case;
end process;
end beh;
-- when x"00400000" => instruction <= x"";
