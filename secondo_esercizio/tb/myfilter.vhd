library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfilter is
port (
  CLK: in std_logic;
  RST_N: in std_logic;
  VIN1: in std_logic;
  VIN2: in std_logic;
  VIN3: in std_logic;
  VOUT1: out std_logic;
  VOUT2: out std_logic;
  VOUT3: out std_logic;

  H0: in std_logic_vector(10 downto 0);
  H1: in std_logic_vector(10 downto 0);
  H2: in std_logic_vector(10 downto 0);
  H3: in std_logic_vector(10 downto 0);
  H4: in std_logic_vector(10 downto 0);
  H5: in std_logic_vector(10 downto 0);
  H6: in std_logic_vector(10 downto 0);
  H7: in std_logic_vector(10 downto 0);
  H8: in std_logic_vector(10 downto 0);
  H9: in std_logic_vector(10 downto 0);
  H10: in std_logic_vector(10 downto 0);
 
  DIN1: in  std_logic_vector(10 downto 0);
  DIN2: in  std_logic_vector(10 downto 0);
  DIN3: in  std_logic_vector(10 downto 0);
  DOUT1: out std_logic_vector(10 downto 0);
  DOUT2: out std_logic_vector(10 downto 0);
  DOUT3: out std_logic_vector(10 downto 0)
  );
end myfilter;

architecture beh of myfilter is

 type PIPE2 is array (0 to 1) of signed(10 downto 0); 
 type PIPE3 is array (0 to 2) of signed(10 downto 0); 
 type PIPE4 is array (0 to 3) of signed(10 downto 0); 
 type PIPE5 is array (0 to 4) of signed(10 downto 0); 
 type DELAY is array (0 to 3) of std_logic;
 type OMIS is array (0 to 10) of signed(10 downto 0);
 type OSIS is array (0 to 3) of signed(10 downto 0);
 type t_coeff is array (0 to 10) of signed(10 downto 0);

signal reg_data0: signed(10 downto 0);
signal reg_data1: signed(10 downto 0);
signal reg_data2: signed(10 downto 0);

signal reg_coeff : t_coeff ;

signal pipe00_2: signed(10 downto 0) := (others=>'0');
signal pipe02_3: signed(10 downto 0) := (others=>'0');
signal pipe00_4: PIPE2;
signal pipe02_5: PIPE2;
signal pipe00_6: PIPE3;
signal pipe02_7: PIPE3;
signal pipe00_8: PIPE4;
signal pipe02_9: PIPE4;
signal pipe00_10: PIPE5;

signal pipe10_1: signed(10 downto 0) := (others=>'0');
signal pipe11_2: signed(10 downto 0) := (others=>'0');
signal pipe10_3: PIPE2;
signal pipe11_4: PIPE2;
signal pipe10_5: PIPE3;
signal pipe11_6: PIPE3;
signal pipe10_7: PIPE4;
signal pipe11_8: PIPE4;
signal pipe10_9: PIPE5;
signal pipe11_10: PIPE5;

signal pipe20_0: signed(10 downto 0) := (others=>'0');
signal pipe21_1: signed(10 downto 0) := (others=>'0');
signal pipe22_2: signed(10 downto 0) := (others=>'0');
signal pipe21_3: PIPE2;
signal pipe22_4: PIPE2;
signal pipe21_5: PIPE3;
signal pipe22_6: PIPE3;
signal pipe21_7: PIPE4;
signal pipe22_8: PIPE4;
signal pipe21_9: PIPE5;
signal pipe22_10: PIPE5;

signal out_mult_in_sum20: OMIS;
signal out_sum_in_sum20: OSIS;

signal reg_add0, reg_add1, reg_add2: signed(10 downto 0) := (others=>'0');

signal delay_vin0: DELAY;
signal delay_vin1: DELAY;
signal delay_vin2: DELAY;

begin

input_registers: process(CLK, RST_N)
begin
if(RST_N ='0') then
  reg_data0 <= (others=>'0');
  reg_data1 <= (others=>'0');
  reg_data2 <= (others=>'0');

reg_coeff(0) <= (others=>'0');
reg_coeff(1) <= (others=>'0');
reg_coeff(2) <= (others=>'0');
reg_coeff(3) <= (others=>'0');
reg_coeff(4) <= (others=>'0');
reg_coeff(5) <= (others=>'0');
reg_coeff(6) <= (others=>'0');
reg_coeff(7) <= (others=>'0');
reg_coeff(8) <= (others=>'0');
reg_coeff(9) <= (others=>'0');
reg_coeff(10) <= (others=>'0');

pipe00_4(0) <= (others=>'0');
pipe02_5(0) <= (others=>'0');
pipe00_6(0) <= (others=>'0');
pipe00_6(1) <= (others=>'0');
pipe02_7(0) <= (others=>'0');
pipe02_7(1) <= (others=>'0');
pipe00_8(0) <= (others=>'0');
pipe00_8(1) <= (others=>'0');
pipe00_8(2) <= (others=>'0');
pipe02_9(0) <= (others=>'0');
pipe02_9(1) <= (others=>'0');
pipe02_9(2) <= (others=>'0');
pipe00_10(0) <= (others=>'0');
pipe00_10(1) <= (others=>'0');
pipe00_10(2) <= (others=>'0');
pipe00_10(3) <= (others=>'0');

pipe00_2 <= (others=>'0');
pipe02_3 <= (others=>'0');
pipe00_4(1) <= (others=>'0');
pipe02_5(1) <= (others=>'0');
pipe00_6(2) <= (others=>'0');
pipe02_7(2) <= (others=>'0');
pipe00_8(3) <= (others=>'0');
pipe02_9(3) <= (others=>'0');
pipe00_10(4) <= (others=>'0');

pipe10_3(0) <= (others=>'0');
pipe11_4(0) <= (others=>'0');
pipe10_5(0) <= (others=>'0');
pipe10_5(1) <= (others=>'0');
pipe11_6(0) <= (others=>'0');
pipe11_6(1) <= (others=>'0');
pipe10_7(0) <= (others=>'0');
pipe10_7(1) <= (others=>'0');
pipe10_7(2) <= (others=>'0');
pipe11_8(0) <= (others=>'0');
pipe11_8(1) <= (others=>'0');
pipe11_8(2) <= (others=>'0');
pipe10_9(0) <= (others=>'0');
pipe10_9(1) <= (others=>'0');
pipe10_9(2) <= (others=>'0');
pipe10_9(3) <= (others=>'0');
pipe11_10(0) <= (others=>'0');
pipe11_10(1) <= (others=>'0');
pipe11_10(2) <= (others=>'0');
pipe11_10(3) <= (others=>'0');

pipe10_1 <= (others=>'0');
pipe11_2 <= (others=>'0');
pipe10_3(1) <= (others=>'0');
pipe11_4(1) <= (others=>'0');
pipe10_5(2) <= (others=>'0');
pipe11_6(2) <= (others=>'0');
pipe10_7(3) <= (others=>'0');
pipe11_8(3) <= (others=>'0');
pipe10_9(4) <= (others=>'0');
pipe11_10(4) <= (others=>'0');

pipe21_3(0) <= (others=>'0');
pipe22_4(0) <= (others=>'0');
pipe21_5(0) <= (others=>'0');
pipe21_5(1) <= (others=>'0');
pipe22_6(0) <= (others=>'0');
pipe22_6(1) <= (others=>'0');
pipe21_7(0) <= (others=>'0');
pipe21_7(1) <= (others=>'0');
pipe21_7(2) <= (others=>'0');
pipe22_8(0) <= (others=>'0');
pipe22_8(1) <= (others=>'0');
pipe22_8(2) <= (others=>'0');
pipe21_9(0) <= (others=>'0');
pipe21_9(1) <= (others=>'0');
pipe21_9(2) <= (others=>'0');
pipe21_9(3) <= (others=>'0');
pipe22_10(0) <= (others=>'0');
pipe22_10(1) <= (others=>'0');
pipe22_10(2) <= (others=>'0');
pipe22_10(3) <= (others=>'0');

pipe20_0 <= (others=>'0');
pipe21_1 <= (others=>'0');
pipe22_2 <= (others=>'0');
pipe21_3(1) <= (others=>'0');
pipe22_4(1) <= (others=>'0');
pipe21_5(2) <= (others=>'0');
pipe22_6(2) <= (others=>'0');
pipe21_7(3) <= (others=>'0');
pipe22_8(3) <= (others=>'0');
pipe21_9(4) <= (others=>'0');
pipe22_10(4) <= (others=>'0');
  
elsif(CLK'event and CLK = '1') then

reg_data0 <= signed(DIN1);
reg_data1 <= signed(DIN2);
reg_data2 <= signed(DIN3);

reg_coeff(0) <= signed(H0);
reg_coeff(1) <= signed(H1);
reg_coeff(2) <= signed(H2);
reg_coeff(3) <= signed(H3);
reg_coeff(4) <= signed(H4);
reg_coeff(5) <= signed(H5);
reg_coeff(6) <= signed(H6);
reg_coeff(7) <= signed(H7);
reg_coeff(8) <= signed(H8);
reg_coeff(9) <= signed(H9);
reg_coeff(10) <= signed(H10);

pipe00_4(0) <= pipe00_4(1);
pipe02_5(0) <= pipe02_5(1);
pipe00_6(0) <= pipe00_6(1);
pipe00_6(1) <= pipe00_6(2);
pipe02_7(0) <= pipe02_7(1);
pipe02_7(1) <= pipe02_7(2);
pipe00_8(0) <= pipe00_8(1);
pipe00_8(1) <= pipe00_8(2);
pipe00_8(2) <= pipe00_8(3);
pipe02_9(0) <= pipe02_9(1);
pipe02_9(1) <= pipe02_9(2);
pipe02_9(2) <= pipe02_9(3);
pipe00_10(0) <= pipe00_10(1);
pipe00_10(1) <= pipe00_10(2);
pipe00_10(2) <= pipe00_10(3);
pipe00_10(3) <= pipe00_10(4);

pipe00_2 <= reg_data0;
pipe02_3 <= reg_data0;
pipe00_4(1) <= reg_data0;
pipe02_5(1) <= reg_data0;
pipe00_6(2) <= reg_data0;
pipe02_7(2) <= reg_data0;
pipe00_8(3) <= reg_data0;
pipe02_9(3) <= reg_data0;
pipe00_10(4) <= reg_data0;

pipe10_3(0) <= pipe10_3(1);
pipe11_4(0) <= pipe11_4(1);
pipe10_5(0) <= pipe10_5(1);
pipe10_5(1) <= pipe10_5(2);
pipe11_6(0) <= pipe11_6(1);
pipe11_6(1) <= pipe11_6(2);
pipe10_7(0) <= pipe10_7(1);
pipe10_7(1) <= pipe10_7(2);
pipe10_7(2) <= pipe10_7(3);
pipe11_8(0) <= pipe11_8(1);
pipe11_8(1) <= pipe11_8(2);
pipe11_8(2) <= pipe11_8(3);
pipe10_9(0) <= pipe10_9(1);
pipe10_9(1) <= pipe10_9(2);
pipe10_9(2) <= pipe10_9(3);
pipe10_9(3) <= pipe10_9(4);
pipe11_10(0) <= pipe11_10(1);
pipe11_10(1) <= pipe11_10(2);
pipe11_10(2) <= pipe11_10(3);
pipe11_10(3) <= pipe11_10(4);

pipe10_1 <= reg_data1;
pipe11_2 <= reg_data1;
pipe10_3(1) <= reg_data1;
pipe11_4(1) <= reg_data1;
pipe10_5(2) <= reg_data1;
pipe11_6(2) <= reg_data1;
pipe10_7(3) <= reg_data1;
pipe11_8(3) <= reg_data1;
pipe10_9(4) <= reg_data1;
pipe11_10(4) <= reg_data1;

pipe21_3(0) <= pipe21_3(1);
pipe22_4(0) <= pipe22_4(1);
pipe21_5(0) <= pipe21_5(1);
pipe21_5(1) <= pipe21_5(2);
pipe22_6(0) <= pipe22_6(1);
pipe22_6(1) <= pipe22_6(2);
pipe21_7(0) <= pipe21_7(1);
pipe21_7(1) <= pipe21_7(2);
pipe21_7(2) <= pipe21_7(3);
pipe22_8(0) <= pipe22_8(1);
pipe22_8(1) <= pipe22_8(2);
pipe22_8(2) <= pipe22_8(3);
pipe21_9(0) <= pipe21_9(1);
pipe21_9(1) <= pipe21_9(2);
pipe21_9(2) <= pipe21_9(3);
pipe21_9(3) <= pipe21_9(4);
pipe22_10(0) <= pipe22_10(1);
pipe22_10(1) <= pipe22_10(2);
pipe22_10(2) <= pipe22_10(3);
pipe22_10(3) <= pipe22_10(4);

pipe20_0 <= reg_data2;
pipe21_1 <= reg_data2;
pipe22_2 <= reg_data2;
pipe21_3(1) <= reg_data2;
pipe22_4(1) <= reg_data2;
pipe21_5(2) <= reg_data2;
pipe22_6(2) <= reg_data2;
pipe21_7(3) <= reg_data2;
pipe22_8(3) <= reg_data2;
pipe21_9(4) <= reg_data2;
pipe22_10(4) <= reg_data2;
    end if;
  end process;

other_registers: process(CLK, RST_N)
  begin
    if(RST_N ='0') then
      out_mult_in_sum20(0) <= (others=>'0');
      out_mult_in_sum20(1) <= (others=>'0');
      out_mult_in_sum20(2) <= (others=>'0');
      out_mult_in_sum20(3) <= (others=>'0');
      out_mult_in_sum20(4) <= (others=>'0');
      out_mult_in_sum20(5) <= (others=>'0');
      out_mult_in_sum20(6) <= (others=>'0');
      out_mult_in_sum20(7) <= (others=>'0');
      out_mult_in_sum20(8) <= (others=>'0');
      out_mult_in_sum20(9) <= (others=>'0');
      out_mult_in_sum20(10) <= (others=>'0');

      out_sum_in_sum20(0) <= (others=>'0');
      out_sum_in_sum20(1) <= (others=>'0');
      out_sum_in_sum20(2) <= (others=>'0');
      out_sum_in_sum20(3) <= (others=>'0');

      reg_add0 <= (others=>'0');
      reg_add1 <= (others=>'0');
      reg_add2 <= (others=>'0');

    elsif(CLK'event and CLK = '1') then
      out_mult_in_sum20(0) <= resize(shift_right(signed(reg_data1* reg_coeff(0)),10),11);
      out_mult_in_sum20(1) <= resize(shift_right(signed(reg_data0* reg_coeff(1)),10),11);
      out_mult_in_sum20(2) <= resize(shift_right(signed(pipe22_2* reg_coeff(2)),10),11);
      out_mult_in_sum20(3) <= resize(shift_right(signed(pipe02_3* reg_coeff(3)),10),11); 
      out_mult_in_sum20(4) <= resize(shift_right(signed(pipe22_4(0)* reg_coeff(4)),10),11);
      out_mult_in_sum20(5) <= resize(shift_right(signed(pipe02_5(0)* reg_coeff(5)),10),11);
      out_mult_in_sum20(6) <= resize(shift_right(signed(pipe22_6(0)* reg_coeff(6)),10),11);
      out_mult_in_sum20(7) <= resize(shift_right(signed(pipe02_7(0)* reg_coeff(7)),10),11);
      out_mult_in_sum20(8) <= resize(shift_right(signed(pipe22_8(0)* reg_coeff(8)),10),11);
      out_mult_in_sum20(9) <= resize(shift_right(signed(pipe02_9(0)* reg_coeff(9)),10),11);
      out_mult_in_sum20(10) <= resize(shift_right(signed(pipe22_10(0)* reg_coeff(10)),10),11);

      out_sum_in_sum20(0) <= resize(shift_right(signed(pipe11_2* reg_coeff(2)),10),11) + resize(shift_right(signed(pipe21_1* reg_coeff(1)),10),11) + resize(shift_right(signed(reg_data0*reg_coeff(0)),10),11);
      out_sum_in_sum20(1) <= resize(shift_right(signed(pipe11_4(0)* reg_coeff(4)),10),11) + resize(shift_right(signed(pipe21_3(0)* reg_coeff(3)),10),11) + resize(shift_right(signed(pipe00_2* reg_coeff(2)),10),11) + resize(shift_right(signed(pipe10_1* reg_coeff(1)),10),11)+ resize(shift_right(signed(pipe20_0* reg_coeff(0)),10),11);
      out_sum_in_sum20(2) <= resize(shift_right(signed(pipe11_6(0)* reg_coeff(6)),10),11) + resize(shift_right(signed(pipe21_5(0)* reg_coeff(5)),10),11) + resize(shift_right(signed(pipe00_4(0)* reg_coeff(4)),10),11) + resize(shift_right(signed(pipe10_3(0)* reg_coeff(3)),10),11) + out_mult_in_sum20(0) + out_mult_in_sum20(1) +  out_mult_in_sum20(2);
      out_sum_in_sum20(3) <= resize(shift_right(signed(pipe11_8(0)* reg_coeff(8)),10),11) + resize(shift_right(signed(pipe21_7(0)* reg_coeff(7)),10),11) + resize(shift_right(signed(pipe00_6(0)* reg_coeff(6)),10),11) + resize(shift_right(signed(pipe10_5(0)* reg_coeff(5)),10),11) + out_mult_in_sum20(3) + out_mult_in_sum20(4) +  out_sum_in_sum20(0);

      reg_add0 <= out_sum_in_sum20(3) + out_mult_in_sum20(9) +  out_mult_in_sum20(10) ;
      reg_add1 <= resize(shift_right(signed(pipe00_10(0)* reg_coeff(10)),10),11) + resize(shift_right(signed(pipe10_9(0)* reg_coeff(9)),10),11) + out_sum_in_sum20(2) + out_mult_in_sum20(7) + out_mult_in_sum20(8);
      reg_add2 <= resize(shift_right(signed(pipe11_10(0)* reg_coeff(10)),10),11) + resize(shift_right(signed(pipe21_9(0)* reg_coeff(9)),10),11) + resize(shift_right(signed(pipe00_8(0)* reg_coeff(8)),10),11) + resize(shift_right(signed(pipe10_7(0)* reg_coeff(7)),10),11) + out_sum_in_sum20(1) + out_mult_in_sum20(5) + out_mult_in_sum20(6);
      end if;
    end process;

    delay_VIN: process(CLK, RST_N)
    begin
      if(RST_N ='0') then
        VOUT1 <= '0';
        VOUT2 <= '0';
        VOUT3 <= '0';

        delay_vin0(3) <= '0';
        delay_vin1(3) <= '0';
        delay_vin2(3) <= '0';

        delay_vin0(2) <= '0';
        delay_vin1(2) <= '0';
        delay_vin2(2) <= '0';

        delay_vin0(1) <= '0';
        delay_vin1(1) <= '0';
        delay_vin2(1) <= '0';

        delay_vin0(0) <= '0';
        delay_vin1(0) <= '0';    
        delay_vin2(0) <= '0';

      elsif(CLK'event and CLK = '1') then

        VOUT1 <= delay_vin0(3);
        VOUT2 <= delay_vin1(3);
        VOUT3 <= delay_vin2(3);

        delay_vin0(3) <= delay_vin0(2);
        delay_vin1(3) <= delay_vin1(2);
        delay_vin2(3) <= delay_vin2(2);

        delay_vin0(2) <= delay_vin0(1);
        delay_vin1(2) <= delay_vin1(1);
        delay_vin2(2) <= delay_vin2(1);

        delay_vin0(1) <= delay_vin0(0);
        delay_vin1(1) <= delay_vin1(0);
        delay_vin2(1) <= delay_vin2(0);

        delay_vin0(0) <= VIN1;
        delay_vin1(0) <= VIN2;    
        delay_vin2(0) <= VIN3;
        end if;
      end process;

    outputs: process(CLK, RST_N)
    begin
      if(RST_N ='0') then
        DOUT1 <= (others=>'0');
        DOUT2 <= (others=>'0');
        DOUT3 <= (others=>'0');

      elsif(CLK'event and CLK = '1') then
        DOUT1 <= std_logic_vector(reg_add0);
        DOUT2 <= std_logic_vector(reg_add1);
        DOUT3 <= std_logic_vector(reg_add2);
        end if;
      end process;
end beh;