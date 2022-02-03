library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity imm_gen is
  port (
    inst: in std_logic_vector(31 downto 0);
    immediate: out std_logic_vector(31 downto 0)
    );
end imm_gen;

architecture beh of imm_gen is

  signal opcode: std_logic_vector(6 downto 0);
  --signal immediate_tmp: std_logic_vector(31 downto 0);

begin  -- beh

opcode <= inst(6 downto 0);

process(opcode, inst)
begin
  case(opcode) is
    when "0010011" => --I type LW, ADDI, ANDI, SRAI
      immediate(0) <= inst(20);
      immediate(4 downto 1) <= inst(24 downto 21);
      immediate(10 downto 5) <= inst(30 downto 25) ;
      immediate(31 downto 11) <= (others => inst(31));

    when "0100011" => -- S type SW
     immediate(0) <= inst(7);
     immediate(4 downto 1) <= inst(11 downto 8);
     immediate(10 downto 5) <= inst(30 downto 25);
     immediate(31 downto 11) <= (others => inst(31));

    when "0110111" => -- U type LUI
     immediate(11 downto 0) <= (others => '0');
     immediate(19 downto 12) <= inst(19 downto 12);
     immediate(30 downto 20) <= inst(30 downto 20);
     immediate(31) <= inst(31);

    when "0010111" => -- U type AUIPC
     immediate(11 downto 0) <= (others => '0');
     immediate(19 downto 12) <= inst(19 downto 12);
     immediate(30 downto 20) <= inst(30 downto 20);
     immediate(31) <= inst(31);

    when "1101111" => --UJ type JAL
    immediate(19 downto 12) <= inst(19 downto 12);
    immediate(11) <= inst(20);
    immediate(10 downto 1) <= inst(30 downto 21);
    immediate(31 downto 20) <= (others => inst(31));

    immediate(0) <= '0';
      
    when "1100011" => --SB type BEQ
     immediate(11) <= inst(7);
     immediate(4 downto 1) <= inst(11 downto 8);
     immediate(10 downto 5) <= inst(30 downto 25);
     immediate(31 downto 12) <= (others => inst(31));
     immediate(0) <= '0'; 

    when others =>
      immediate <= (others => '0');
  end case;
end process;    
end beh;
