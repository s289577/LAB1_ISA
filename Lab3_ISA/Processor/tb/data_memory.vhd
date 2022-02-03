library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_memory is
  port (
    address: in std_logic_vector(31 downto 0);
    write_data: in std_logic_vector(31 downto 0);
    mem_write: in std_logic;
    mem_read: in std_logic;
    data: out std_logic_vector(31 downto 0)
    );
end data_memory;

architecture beh of data_memory is

  signal cell_1: std_logic_vector(31 downto 0);
  signal cell_2: std_logic_vector(31 downto 0);
  signal tmp: std_logic_vector(31 downto 0);

begin  -- beh

process(address, mem_write, mem_read, tmp)
begin 
  if(mem_read = '1' and mem_write = '0') then
    case address is
      when x"10010000" => tmp <= x"0000000a";
      when x"10010004" => tmp <= x"FFFFFFD1";
      when x"10010008" => tmp <= x"00000016";
      when x"1001000c" => tmp <= x"FFFFFFFD";
      when x"10010010" => tmp <= x"0000000F";
      when x"10010014" => tmp <= x"0000001B";
      when x"10010018" => tmp <= x"FFFFFFFC";
      when others => tmp <= x"00000000";
    end case;
  elsif(mem_write = '1' and mem_read = '0') then
    case address is
      when x"1001001c" => cell_1 <= write_data; -- correct value to store x"00000003"
      when others => cell_2 <= x"00000000";
    end case;
  end if;
  data <= tmp;
end process;
end beh;