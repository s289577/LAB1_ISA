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
    when x"00400000" => instruction <= x"00700813"; --ADDI
    when x"00400004" => instruction <= x"0fc10217"; --AUIPC
    when x"00400008" => instruction <= x"ffc20213"; --ADDI DP
    when x"0040000c" => instruction <= x"0fc10297"; --AUIPC
    when x"00400010" => instruction <= x"01028293"; --ADDI DP
    when x"00400014" => instruction <= x"400006b7"; --LUI
    when x"00400018" => instruction <= x"fff68693"; --ADDI DP
    when x"0040001c" => instruction <= x"02080863"; -- BEQ 
    when x"00400020" => instruction <= x"00022403"; --LW
    when x"00400024" => instruction <= x"41f45493"; --SRAI
    when x"00400028" => instruction <= x"00944533"; -- XOR
    when x"0040002c" => instruction <= x"0014f493"; --ANDI
    when x"00400030" => instruction <= x"00950533"; -- ADD
    when x"00400034" => instruction <= x"00420213"; --ADDI
    when x"00400038" => instruction <= x"fff80813"; --ADDI
    when x"0040003c" => instruction <= x"00d525b3"; --SLT
    when x"00400040" => instruction <= x"fc058ee3"; --BEQ
    when x"00400044" => instruction <= x"000506b3"; --ADD
    when x"00400048" => instruction <= x"fd5ff0ef"; --JAL
    when x"0040004c" => instruction <= x"00d2a023"; --SW
    when x"00400050" => instruction <= x"000000ef"; --JAL
    when x"00400054" => instruction <= x"00000013"; --ADDI

    when others => instruction <= x"00000000";

  end case;
end process;
end beh;
-- when x"00400000" => instruction <= x"";
