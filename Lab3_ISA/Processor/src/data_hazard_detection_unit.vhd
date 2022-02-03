library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_hazard_detection_unit is
  port (
    rd: in std_logic_vector(4 downto 0);
    rs1: in std_logic_vector(4 downto 0);
    rs2: in std_logic_vector(4 downto 0);
    nop_enable: out std_logic
  );
end data_hazard_detection_unit;

architecture beh of data_hazard_detection_unit is
  signal comp1: std_logic;
  signal comp2: std_logic;

begin  -- beh
  comp1 <= '1' when rd = rs1
           else '0';
  comp2 <= '1' when rd = rs2
          else '0';
nop_enable <=  comp1 OR comp2;
end beh;