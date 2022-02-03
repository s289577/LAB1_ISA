library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity registers is
  port (
    clk: in std_logic;
    rst: in std_logic;
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
  signal registers : array_reg;

begin  -- beh

process(clk, rst, reg_write)
begin
  if(rst = '0') then
    registers(0) <= (others => '0');
    registers(1) <= (others => '0');
    registers(2) <= (others => '0');
    registers(3) <= (others => '0');
    registers(4) <= (others => '0');
    registers(5) <= (others => '0');
    registers(6) <= (others => '0');
    registers(7) <= (others => '0');
    registers(8) <= (others => '0');
    registers(9) <= (others => '0');
    registers(10) <= (others => '0');
    registers(11) <= (others => '0');
    registers(12) <= (others => '0');
    registers(13) <= (others => '0');
    registers(14) <= (others => '0');
    registers(15) <= (others => '0');
    registers(16) <= (others => '0');
    registers(17) <= (others => '0');
    registers(18) <= (others => '0');
    registers(19) <= (others => '0');
    registers(20) <= (others => '0');
    registers(21) <= (others => '0');
    registers(22) <= (others => '0');
    registers(23) <= (others => '0');
    registers(24) <= (others => '0');
    registers(25) <= (others => '0');
    registers(26) <= (others => '0');
    registers(27) <= (others => '0');
    registers(28) <= (others => '0');
    registers(29) <= (others => '0');
    registers(30) <= (others => '0');
    registers(31) <= (others => '0');
  end if;

  if(clk = '1' and clk'event) then
   if(reg_write = '1') then
    registers(to_integer(unsigned(write_register))) <= write_data;
   else
    NULL;
   end if;
 else
  NULL;
 end if;
end process;

read_data_1 <= registers(to_integer(unsigned(read_register_1)));
read_data_2 <= registers(to_integer(unsigned(read_register_2)));

--registers(to_integer(unsigned(write_register))) <= write_data when reg_write = '1' else registers(to_integer(unsigned(write_register)));

end beh;


