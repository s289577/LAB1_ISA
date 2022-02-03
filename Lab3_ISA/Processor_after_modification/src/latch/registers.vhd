library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity registers is
  port (
    reg_write : in std_logic; -- write enable
    read_register_1 : in std_logic_vector(4 downto 0); -- address rs 1
    read_register_2 : in std_logic_vector(4 downto 0); -- address rs 2
    write_register : in std_logic_vector(4 downto 0); -- address rd
    write_data : in std_logic_vector(31 downto 0); -- data to write
    read_data_1 : out std_logic_vector(31 downto 0); -- data in rs1
    read_data_2 : out std_logic_vector(31 downto 0) -- data in rs2 
    );
end registers;

architecture beh of registers is

  type array_reg is array (31 downto 0) of std_logic_vector(31 downto 0);
  signal registers : array_reg := (others => (others => '0'));

begin  -- beh
  
registers(to_integer(unsigned(write_register))) <= write_data when reg_write = '1' else registers(to_integer(unsigned(write_register)));

read_data_1 <= registers(to_integer(unsigned(read_register_1)));
read_data_2 <= registers(to_integer(unsigned(read_register_2)));

end beh;


