library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity control_unit is
  port (
    opcode: in std_logic_vector(6 downto 0);
    funct: in std_logic_vector(2 downto 0);
    branch: out std_logic;
    mem_read: out std_logic;
    reg_write: out std_logic;
    alu_op_sel: out std_logic_vector(2 downto 0);
    mem_write: out std_logic;
    alu_src: out std_logic_vector(1 downto 0);
    mem_to_reg: out std_logic_vector(1 downto 0)
    );
end control_unit;

architecture beh of control_unit is

begin  -- beh
  process(opcode, funct)

  begin
    case opcode is
      when "0110111" => 
        branch <= '0';
        mem_read <= '0';
        reg_write <= '1';
        alu_op_sel <= "110";
        mem_write <= '0';
        alu_src <= "01";
        mem_to_reg <= "00";

      when "0010111" => 
        branch <= '0';
        mem_read <= '0';
        reg_write <= '1';
        alu_op_sel <= "110";
        mem_write <= '0';
        alu_src <= "01";
        mem_to_reg <= "11";

      when "1101111" => 
        branch <= '1';
        mem_read <= '0';
        reg_write <= '1';
        alu_op_sel <= "110";
        mem_write <= '0';
        alu_src <= "11";
        mem_to_reg <= "00";

      when "1100011" =>
        branch <= '1';
        mem_read <= '0';
        reg_write <= '0';
        alu_op_sel <= "100";
        mem_write <= '0';
        alu_src <= "00";
        mem_to_reg <= "00";

       when "0000011" => --LW
          branch <= '0';
          mem_read <= '1';
          reg_write <= '1';
          alu_op_sel <= "000";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "01";

      when "0010011" =>
        if(funct = "000") then
          branch <= '0';
          mem_read <= '0';
          reg_write <= '1';
          alu_op_sel <= "000";
          mem_write <= '0';
          alu_src <= "01";
          mem_to_reg <= "00";
          
        elsif(funct = "111") then
          branch <= '0';
          mem_read <= '0';
          reg_write <= '1';
          alu_op_sel <= "001";
          mem_write <= '0';
          alu_src <= "01";
          mem_to_reg <= "00";
           
        elsif(funct = "101") then
          branch <= '0';
          mem_read <= '0';
          reg_write <= '1';
          alu_op_sel <= "101";
          mem_write <= '0';
          alu_src <= "01";
          mem_to_reg <= "00";
        
        else 
          branch <= '0';
          mem_read <= '0';
          reg_write <= '0';
          alu_op_sel <= "000";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "00";
        end if;

        when "0100011" =>
          branch <= '0';
          mem_read <= '0';
          reg_write <= '0';
          alu_op_sel <= "000";
          mem_write <= '1';
          alu_src <= "01";
          mem_to_reg <= "00";

        when "0110011" =>
        if(funct = "000") then
          branch <= '0';
          mem_read <= '0';
          reg_write <= '1';
          alu_op_sel <= "000";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "00";

        elsif(funct = "010") then
          branch <= '0';
          mem_read <= '0';
          reg_write <= '1';
          alu_op_sel <= "011";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "00";
          
        elsif(funct = "100") then
          branch <= '0';
          mem_read <= '0';
          reg_write <= '1';
          alu_op_sel <= "010";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "00";

        else
          branch <= '0';
          mem_read <= '0';
          reg_write <= '0';
          alu_op_sel <= "000";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "00";
        end if;   

      when "1111111" => 
        branch <= '0';
        mem_read <= '0';
        reg_write <= '1';
        alu_op_sel <= "111";
        mem_write <= '0';
        alu_src <= "00";
        mem_to_reg <= "00";

      when others =>
          branch <= '0';
          mem_read <= '0';
          reg_write <= '0';
          alu_op_sel <= "000";
          mem_write <= '0';
          alu_src <= "00";
          mem_to_reg <= "00";
      end case;
    end process;
end beh;
