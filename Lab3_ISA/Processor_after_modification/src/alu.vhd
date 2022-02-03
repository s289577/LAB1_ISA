library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity alu is
  port (
    alu_op_sel: in std_logic_vector(2 downto 0);
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    alu_result: out std_logic_vector(31 downto 0);
    zero: out std_logic
    );
end alu;

architecture beh of alu is
signal dummy_zero: std_logic:= '0';

begin  -- beh
process(alu_op_sel, a, b)

variable shift_amount: natural := 0;

begin
shift_amount := to_integer(unsigned(b));

  case alu_op_sel is
    when "000" =>
    alu_result <= a + b;
    dummy_zero <= '0';

    when "001" =>
    alu_result <= a AND b;
    dummy_zero <= '0';
    
    when "010" =>
    alu_result <= a XOR b;
    dummy_zero <= '0';

    when "011" =>
      if(a < b) then
        alu_result(31 downto 1) <= (others => '0');
        alu_result(0) <= '1';
        dummy_zero <= '0';
      else
      alu_result <= (others => '0');
      dummy_zero <= '0';
      end if;
    
    when "100" =>
      if(a = b) then
        dummy_zero <= '1';
		alu_result <= (others => '0');
      else
      	dummy_zero <= '0';
		alu_result <= (others => '0');
      end if;

    when "101" =>
    alu_result <= std_logic_vector(shift_right(signed(a),shift_amount));
    dummy_zero <= '0';
    
    when "110" =>
    alu_result <= b;
    dummy_zero <= '1';

    when "111" =>
     if(a(31) = '0') then
      alu_result <= a;
     else
     alu_result <= (not(a) + 1);
     end if;
    dummy_zero <= '0';
  
    when others =>
    alu_result <= (others => '0');
    dummy_zero <= '0';
  end case;
  
end process;

  zero <= dummy_zero;
end beh;
