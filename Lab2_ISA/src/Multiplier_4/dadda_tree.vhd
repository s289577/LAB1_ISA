library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity dadda_tree is
  port (
    p1: in std_logic_vector(32 downto 0);
    p2: in std_logic_vector(32 downto 0);
    p3: in std_logic_vector(32 downto 0);
    p4: in std_logic_vector(32 downto 0);
    p5: in std_logic_vector(32 downto 0);
    p6: in std_logic_vector(32 downto 0);
    p7: in std_logic_vector(32 downto 0);
    p8: in std_logic_vector(32 downto 0);
    p9: in std_logic_vector(32 downto 0);
    p10: in std_logic_vector(32 downto 0);
    p11: in std_logic_vector(32 downto 0);
    p12: in std_logic_vector(32 downto 0);
    p13: in std_logic_vector(32 downto 0);
    p14: in std_logic_vector(32 downto 0);
    p15: in std_logic_vector(32 downto 0);
    p16: in std_logic_vector(32 downto 0);
    p17: in std_logic_vector(31 downto 0);

    s1: in std_logic;
    s2: in std_logic;
    s3: in std_logic;
    s4: in std_logic;
    s5: in std_logic;
    s6: in std_logic;
    s7: in std_logic;
    s8: in std_logic;
    s9: in std_logic;
    s10: in std_logic;
    s11: in std_logic;
    s12: in std_logic;
    s13: in std_logic;
    s14: in std_logic;
    s15: in std_logic;
    s16: in std_logic;

    result: out std_logic_vector(63 downto 0)
    );
end dadda_tree;

architecture beh of dadda_tree is
-- First stage (17 rows)
signal row1:  std_logic_vector(35 downto 0);
signal row2:  std_logic_vector(35 downto 0);
signal row3:  std_logic_vector(35 downto 0);
signal row4:  std_logic_vector(35 downto 0);
signal row5:  std_logic_vector(35 downto 0);
signal row6:  std_logic_vector(35 downto 0);
signal row7:  std_logic_vector(35 downto 0);
signal row8:  std_logic_vector(35 downto 0);
signal row9:  std_logic_vector(35 downto 0);
signal row10: std_logic_vector(35 downto 0);
signal row11: std_logic_vector(35 downto 0);
signal row12: std_logic_vector(35 downto 0);
signal row13: std_logic_vector(35 downto 0);
signal row14: std_logic_vector(35 downto 0);
signal row15: std_logic_vector(35 downto 0);
signal row16: std_logic_vector(34 downto 0);
signal row17: std_logic_vector(32 downto 0);

--Second Stage (13 rows)
signal row1_2:  std_logic_vector(63 downto 0);
signal row2_2:  std_logic_vector(62 downto 0);
signal row3_2:  std_logic_vector(59 downto 0);
signal row4_2:  std_logic_vector(55 downto 0);
signal row5_2:  std_logic_vector(51 downto 0);
signal row6_2:  std_logic_vector(47 downto 0);
signal row7_2:  std_logic_vector(43 downto 0);
signal row8_2:  std_logic_vector(39 downto 0);
signal row9_2:  std_logic_vector(35 downto 0); 
signal row10_2: std_logic_vector(31 downto 0);
signal row11_2: std_logic_vector(27 downto 0);
signal row12_2: std_logic_vector(23 downto 0);
signal row13_2: std_logic_vector(20 downto 0);

--Third Stage (9 rows)
signal row1_3: std_logic_vector(63 downto 0);
signal row2_3: std_logic_vector(62 downto 0);
signal row3_3: std_logic_vector(59 downto 0);
signal row4_3: std_logic_vector(55 downto 0);
signal row5_3: std_logic_vector(51 downto 0);
signal row6_3: std_logic_vector(47 downto 0);
signal row7_3: std_logic_vector(43 downto 0);
signal row8_3: std_logic_vector(39 downto 0);
signal row9_3: std_logic_vector(36 downto 0);

--Fourth Stage (6 rows)
signal row1_4: std_logic_vector(63 downto 0);
signal row2_4: std_logic_vector(62 downto 0);
signal row3_4: std_logic_vector(59 downto 0);
signal row4_4: std_logic_vector(55 downto 0);
signal row5_4: std_logic_vector(51 downto 0);
signal row6_4: std_logic_vector(48 downto 0);

--Fifth Stage (4 rows)
signal row1_5: std_logic_vector(63 downto 0);
signal row2_5: std_logic_vector(62 downto 0);
signal row3_5: std_logic_vector(59 downto 0);
signal row4_5: std_logic_vector(56 downto 0);

--Sixth Stage (3 rows)
signal row1_6: std_logic_vector(63 downto 0);
signal row2_6: std_logic_vector(62 downto 0);
signal row3_6: std_logic_vector(60 downto 0);

--Seventh Stage (2 rows)
signal row1_7: std_logic_vector(63 downto 0);
signal row2_7: std_logic_vector(63 downto 0);

-- Result

signal product: std_logic_vector(64 downto 0);
signal carry: std_logic_vector(64 downto 0);

component ha is
  port (
    a: in std_logic;
    b: in std_logic;
    sum: out std_logic;
    c_out: out std_logic
    );
end component;

component fa is
  port (
    c_in: in std_logic;
    a: in std_logic;
    b: in std_logic;
    sum: out std_logic;
    c_out: out std_logic
    );
end component;

begin  -- beh
  row1(32 downto 0) <= p1;
  row1(33) <= s1;
  row1(34) <= s1;
  row1(35) <= NOT(s1);

  row2(0) <= s1;
  row2(33 downto 1) <= p2;
  row2(34) <= NOT(s2);
  row2(35) <= '1';

  row3(0) <= s2;
  row3(33 downto 1) <= p3;
  row3(34) <= NOT(s3);
  row3(35) <= '1';

  row4(0) <= s3;
  row4(33 downto 1) <= p4;
  row4(34) <= NOT(s4);
  row4(35) <= '1';

  row5(0) <= s4;
  row5(33 downto 1) <= p5;
  row5(34) <= NOT(s5);
  row5(35) <= '1';

  row6(0) <= s5;
  row6(33 downto 1) <= p6;
  row6(34) <= NOT(s6);
  row6(35) <= '1';
  
  row7(0) <= s6;
  row7(33 downto 1) <= p7;
  row7(34) <= NOT(s7);
  row7(35) <= '1';
  
  row8(0) <= s7;
  row8(33 downto 1) <= p8;
  row8(34) <= NOT(s8);
  row8(35) <= '1';

  row9(0) <= s8;
  row9(33 downto 1) <= p9;
  row9(34) <= NOT(s9);
  row9(35) <= '1';
  
  row10(0) <= s9;
  row10(33 downto 1) <= p10;
  row10(34) <= NOT(s10);
  row10(35) <= '1';

  row11(0) <= s10;
  row11(33 downto 1) <= p11;
  row11(34) <= NOT(s11);
  row11(35) <= '1';

  row12(0) <= s11;
  row12(33 downto 1) <= p12;
  row12(34) <= NOT(s12);
  row12(35) <= '1';

  row13(0) <= s12;
  row13(33 downto 1) <= p13;
  row13(34) <= NOT(s13);
  row13(35) <= '1';

  row14(0) <= s13;
  row14(33 downto 1) <= p14;
  row14(34) <= NOT(s14);
  row14(35) <= '1';

  row15(0) <= s14;
  row15(33 downto 1) <= p15;
  row15(34) <= NOT(s15);
  row15(35) <= '1';

  row16(0) <= s15;
  row16(33 downto 1) <= p16;
  row16(34) <= NOT(s16);

  row17(0) <= s16;
  row17(32 downto 1) <= p17;

  -- Second stage
  
  add1:  ha port map(row1(24), row2(23), row1_2(24), row2_2(24)); 
  add2:  ha port map(row1(25), row2(24), row1_2(25), row2_2(25));
  add3:  ha port map(row4(21), row5(19), row3_2(23), row4_2(22));
  add4:  ha port map(row4(22), row5(20), row3_2(24), row4_2(23));
  add5:  ha port map(row7(17), row8(15), row5_2(21), row6_2(20));
  add6:  ha port map(row7(18), row8(16), row5_2(22), row6_2(21));
  add7:  ha port map(row10(13), row11(11), row7_2(19), row8_2(18));
  add8:  ha port map(row10(14), row11(12), row7_2(20), row8_2(19));

  add9:  ha port map(row5(35), row6(33), row1_2(42), row2_2(42));
  add10: ha port map(row7(29), row8(27), row3_2(37), row4_2(36));
  add11: ha port map(row9(23), row10(21), row5_2(31), row6_2(30));
  add12: ha port map(row11(17), row12(15), row7_2(25), row8_2(24));

   gen_add1: for i in 0 to 9 generate
   fa1 : fa port map(row1(26+i), row2(25+i), row3(23+i), row1_2(26+i), row2_2(26+i));
   end generate;

   gen_add2: for i in 0 to 7 generate
   fa2 : fa port map(row4(23+i), row5(21+i), row6(19+i), row3_2(25+i), row4_2(24+i));
   end generate;

   gen_add3: for i in 0 to 5 generate
   fa3 : fa port map(row7(19+i), row8(17+i), row9(15+i), row5_2(23+i), row6_2(22+i));
   end generate;

   gen_add4: for i in 0 to 3 generate
   fa4 : fa port map(row10(15+i), row11(13+i), row12(11+i), row7_2(21+i), row8_2(20+i));
   end generate;
   
   fa5 : fa port map(row2(35), row3(33), row4(31), row1_2(36), row2_2(36));
   fa6 : fa port map(row5(29), row6(27), row7(25), row3_2(33), row4_2(32));
   fa7 : fa port map(row8(23), row9(21), row10(19), row5_2(29), row6_2(28));

   fa8 : fa port map(row3(34), row4(32), row5(30), row1_2(37), row2_2(37));
   fa9 : fa port map(row6(28), row7(26), row8(24), row3_2(34), row4_2(33));
   fa10 : fa port map(row9(22), row10(20), row11(18), row5_2(30), row6_2(29));

   fa11 : fa port map(row3(35), row4(33), row5(31), row1_2(38), row2_2(38));
   fa12 : fa port map(row6(29), row7(27), row8(25), row3_2(35), row4_2(34));

   fa26 : fa port map(row4(34), row5(32), row6(30), row1_2(39), row2_2(39));
   fa27 : fa port map(row7(28), row8(26), row9(24), row3_2(36), row4_2(35));

   fa13 : fa port map(row4(35), row5(33), row6(31), row1_2(40), row2_2(40));

   fa14 : fa port map(row5(34), row6(32), row7(30), row1_2(41), row2_2(41));

  row1_2(23 downto 0) <= row1(23 downto 0);
  row2_2(22 downto 0) <= row2(22 downto 0);
  row3_2(20 downto 0) <= row3(20 downto 0);
  row4_2(18 downto 0) <= row4(18 downto 0);
  row5_2(16 downto 0) <= row5(16 downto 0);
  row6_2(14 downto 0) <= row6(14 downto 0);
  row7_2(12 downto 0) <= row7(12 downto 0);
  row8_2(10 downto 0) <= row8(10 downto 0);
  row9_2(8 downto 0) <= row9(8 downto 0);
  row10_2(6 downto 0) <= row10(6 downto 0);
  row11_2(4 downto 0) <= row11(4 downto 0);
  row12_2(2 downto 0) <= row12(2 downto 0);
  row13_2(0) <= row13(0);
  
  row2_2(23) <= row3(21);
  row3_2(21) <= row4(19);
  row4_2(19) <= row5(17);
  row5_2(17) <= row6(15);
  row6_2(15) <= row7(13);
  row7_2(13) <= row8(11);
  row8_2(11) <= row9(9);
  row9_2(9) <= row10(7);
  row10_2(7) <= row11(5);
  row11_2(5) <= row12(3);
  row12_2(3) <= row13(1);
  row13_2(1) <= row14(0);

  row3_2(22) <= row3(22);
  row4_2(20) <= row4(20);
  row5_2(18) <= row5(18);
  row6_2(16) <= row6(16);
  row7_2(14) <= row7(14);
  row8_2(12) <= row8(12);
  row9_2(10) <= row9(10);
  row10_2(8) <= row10(8);
  row11_2(6) <= row11(6);
  row12_2(4) <= row12(4);
  row13_2(2) <= row13(2);

  row4_2(21) <= row6(17);
  row5_2(19) <= row7(15);
  row6_2(17) <= row8(13);
  row7_2(15) <= row9(11);
  row8_2(13) <= row10(9);
  row9_2(11) <= row11(7);
  row10_2(9) <= row12(5);
  row11_2(7) <= row13(3);
  row12_2(5) <= row14(1);
  row13_2(3) <= row15(0);
  
  row5_2(20) <= row6(18);
  row6_2(18) <= row7(16);
  row7_2(16) <= row8(14);
  row8_2(14) <= row9(12);
  row9_2(12) <= row10(10);
  row10_2(10) <= row11(8);
  row11_2(8) <= row12(6);
  row12_2(6) <= row13(4);
  row13_2(4) <= row14(2);
  
  row6_2(19) <= row9(13);
  row7_2(17) <= row10(11);
  row8_2(15) <= row11(9);
  row9_2(13) <= row12(7);
  row10_2(11) <= row13(5);
  row11_2(9) <= row14(3);
  row12_2(7) <= row15(1);
  row13_2(5) <= row16(0);

  row7_2(18) <= row9(14);
  row8_2(16) <= row10(12);
  row9_2(14) <= row11(10);
  row10_2(12) <= row12(8);
  row11_2(10) <= row13(6);
  row12_2(8) <= row14(4);
  row13_2(6) <= row15(2);

  row8_2(17) <= row12(9);
  row9_2(15) <= row13(7);
  row10_2(13) <= row14(5);
  row11_2(11) <= row15(3);
  row12_2(9) <= row16(1);
  row13_2(7) <= row17(0);

  row9_2(16) <= row12(10);
  row10_2(14) <= row13(8);
  row11_2(12) <= row14(6);
  row12_2(10) <= row15(4);
  row13_2(8) <= row16(2);

  row9_2(17) <= row13(9);
  row10_2(15) <= row14(7);
  row11_2(13) <= row15(5);
  row12_2(11) <= row16(3);
  row13_2(9) <= row17(1);

  row9_2(18) <= row13(10);
  row10_2(16) <= row14(8);
  row11_2(14) <= row15(6);
  row12_2(12) <= row16(4);
  row13_2(10) <= row17(2);

  row9_2(19) <= row13(11);
  row10_2(17) <= row14(9);
  row11_2(15) <= row15(7);
  row12_2(13) <= row16(5);
  row13_2(11) <= row17(3);

  row9_2(20) <= row13(12);
  row10_2(18) <= row14(10);
  row11_2(16) <= row15(8);
  row12_2(14) <= row16(6);
  row13_2(12) <= row17(4);

  row9_2(21) <= row13(13);
  row10_2(19) <= row14(11);
  row11_2(17) <= row15(9);
  row12_2(15) <= row16(7);
  row13_2(13) <= row17(5);

  row7_2(26) <= row12(16);
  row9_2(22) <= row13(14);
  row10_2(20) <= row14(12);
  row11_2(18) <= row15(10);
  row12_2(16) <= row16(8);
  row13_2(14) <= row17(6);

  row7_2(27) <= row11(19);
  row8_2(25) <= row12(17);
  row9_2(23) <= row13(15);
  row10_2(21) <= row14(13);
  row11_2(19) <= row15(11);
  row12_2(17) <= row16(9);
  row13_2(15) <= row17(7);

  row5_2(32) <= row10(22);
  row7_2(28) <= row11(20);
  row8_2(26) <= row12(18);
  row9_2(24) <= row13(16);
  row10_2(22) <= row14(14);
  row11_2(20) <= row15(12);
  row12_2(18) <= row16(10);
  row13_2(16) <= row17(8);

  row5_2(33) <= row9(25);
  row6_2(31) <= row10(23);
  row7_2(29) <= row11(21);
  row8_2(27) <= row12(19);
  row9_2(25) <= row13(17);
  row10_2(23) <= row14(15);
  row11_2(21) <= row15(13);
  row12_2(19) <= row16(11);
  row13_2(17) <= row17(9);
-- Gatto
  row3_2(38) <= row8(28);
  row5_2(34) <= row9(26);
  row6_2(32) <= row10(24);
  row7_2(30) <= row11(22);
  row8_2(28) <= row12(20);
  row9_2(26) <= row13(18);
  row10_2(24) <= row14(16);
  row11_2(22) <= row15(14);
  row12_2(20) <= row16(12);
  row13_2(18) <= row17(10);
-- Gatto
  row3_2(39) <= row7(31);
  row4_2(37) <= row8(29);
  row5_2(35) <= row9(27);
  row6_2(33) <= row10(25);
  row7_2(31) <= row11(23);
  row8_2(29) <= row12(21);
  row9_2(27) <= row13(19);
  row10_2(25) <= row14(17);
  row11_2(23) <= row15(15);
  row12_2(21) <= row16(13);
  row13_2(19) <= row17(11);

  row3_2(40) <= row7(32);
  row4_2(38) <= row8(30);
  row5_2(36) <= row9(28);
  row6_2(34) <= row10(26);
  row7_2(32) <= row11(24);
  row8_2(30) <= row12(22);
  row9_2(28) <= row13(20);
  row10_2(26) <= row14(18);
  row11_2(24) <= row15(16);
  row12_2(22) <= row16(14);
  row13_2(20) <= row17(12);
  
  row2_2(43) <= row7(33);
  row3_2(41) <= row8(31);
  row4_2(39) <= row9(29);
  row5_2(37) <= row10(27);
  row6_2(35) <= row11(25);
  row7_2(33) <= row12(23);
  row8_2(31) <= row13(21);
  row9_2(29) <= row14(19);
  row10_2(27) <= row15(17);
  row11_2(25) <= row16(15);
  row12_2(23) <= row17(13);

  row2_2(44) <= row8(32);
  row3_2(42) <= row9(30);
  row4_2(40) <= row10(28);
  row5_2(38) <= row11(26);
  row6_2(36) <= row12(24);
  row7_2(34) <= row13(22);
  row8_2(32) <= row14(20);
  row9_2(30) <= row15(18);
  row10_2(28) <= row16(16);
  row11_2(26) <= row17(14);

  row2_2(45) <= row8(33);
  row3_2(43) <= row9(31);
  row4_2(41) <= row10(29);
  row5_2(39) <= row11(27);
  row6_2(37) <= row12(25);
  row7_2(35) <= row13(23);
  row8_2(33) <= row14(21);
  row9_2(31) <= row15(19);
  row10_2(29) <= row16(17);
  row11_2(27) <= row17(15);

  row2_2(46) <= row9(32);
  row3_2(44) <= row10(30);
  row4_2(42) <= row11(28);
  row5_2(40) <= row12(26);
  row6_2(38) <= row13(24);
  row7_2(36) <= row14(22);
  row8_2(34) <= row15(20);
  row9_2(32) <= row16(18);
  row10_2(30) <= row17(18);

  row2_2(47) <= row9(33);
  row3_2(45) <= row10(31);
  row4_2(43) <= row11(29);
  row5_2(41) <= row12(27);
  row6_2(39) <= row13(25);
  row7_2(37) <= row14(23);
  row8_2(35) <= row15(21);
  row9_2(33) <= row16(19);
  row10_2(31) <= row17(17);

  row2_2(48) <= row10(32);
  row3_2(46) <= row11(30);
  row4_2(44) <= row12(28);
  row5_2(42) <= row13(26);
  row6_2(40) <= row14(24);
  row7_2(38) <= row15(22);
  row8_2(36) <= row16(20);
  row9_2(34) <= row17(18);
  
  row2_2(49) <= row10(33);
  row3_2(47) <= row11(31);
  row4_2(45) <= row12(29);
  row5_2(43) <= row13(27);
  row6_2(41) <= row14(25);
  row7_2(39) <= row15(23);
  row8_2(37) <= row16(21);
  row9_2(35) <= row17(19);

  row2_2(50) <= row11(32);
  row3_2(48) <= row12(30);
  row4_2(46) <= row13(28);
  row5_2(44) <= row14(26);
  row6_2(42) <= row15(24);
  row7_2(40) <= row16(22);
  row8_2(38) <= row17(20);
  
  row2_2(51) <= row11(33);
  row3_2(49) <= row12(31);
  row4_2(47) <= row13(29);
  row5_2(45) <= row14(27);
  row6_2(43) <= row15(25);
  row7_2(41) <= row16(23);
  row8_2(39) <= row17(21);

  row2_2(52) <= row12(32);
  row3_2(50) <= row13(30);
  row4_2(48) <= row14(28);
  row5_2(46) <= row15(26);
  row6_2(44) <= row16(24);
  row7_2(42) <= row17(22);
  
  row2_2(53) <= row12(33);
  row3_2(51) <= row13(31);
  row4_2(49) <= row14(29);
  row5_2(47) <= row15(27);
  row6_2(45) <= row16(25);
  row7_2(43) <= row17(23);

  row2_2(54) <= row13(32);
  row3_2(52) <= row14(30);
  row4_2(50) <= row15(28);
  row5_2(48) <= row16(26);
  row6_2(46) <= row17(24);

  row2_2(55) <= row13(33);
  row3_2(53) <= row14(31);
  row4_2(51) <= row15(29);
  row5_2(49) <= row16(27);
  row6_2(47) <= row17(25);
  
  row2_2(56) <= row14(32);
  row3_2(54) <= row15(30);
  row4_2(52) <= row16(28);
  row5_2(50) <= row17(26);

  row2_2(57) <= row14(33);
  row3_2(55) <= row15(31);
  row4_2(53) <= row16(29);
  row5_2(51) <= row17(27);

  row2_2(58) <= row15(32);
  row3_2(56) <= row16(30);
  row4_2(54) <= row17(28);

  row2_2(59) <= row15(33);
  row3_2(57) <= row16(31);
  row4_2(55) <= row17(29);

  row2_2(60) <= row16(32);
  row3_2(58) <= row17(30);

  row2_2(61) <= row16(33);
  row3_2(59) <= row17(31);

  row2_2(62) <= row17(32);
 
  row1_2(43) <= row6(34);
  row1_2(44) <= row6(35);
  row1_2(45) <= row7(34);
  row1_2(46) <= row7(35);
  row1_2(47) <= row8(34);
  row1_2(48) <= row8(35);
  row1_2(49) <= row9(34);
  row1_2(50) <= row9(35);
  row1_2(51) <= row10(34);
  row1_2(52) <= row10(35);
  row1_2(53) <= row11(34);
  row1_2(54) <= row11(35);
  row1_2(55) <= row12(34);
  row1_2(56) <= row12(35);
  row1_2(57) <= row13(34);
  row1_2(58) <= row13(35);
  row1_2(59) <= row14(34);
  row1_2(60) <= row14(35);
  row1_2(61) <= row15(34);
  row1_2(62) <= row15(35);
  row1_2(63) <= row16(34);
 
  -- Third stage
  gen_add5: for i in 0 to 31 generate
  fa15 : fa port map(row1_2(18+i), row2_2(17+i), row3_2(15+i), row1_3(18+i), row2_3(18+i));
  end generate;

  gen_add6: for i in 0 to 27 generate
  fa16 : fa port map(row4_2(15+i), row5_2(13+i), row6_2(11+i), row3_3(17+i), row4_3(16+i));
  end generate;

  gen_add7: for i in 0 to 23 generate
  fa17 : fa port map(row7_2(11+i), row8_2(9+i), row9_2(7+i), row5_3(15+i), row6_3(14+i));
  end generate;

  gen_add8: for i in 0 to 19 generate
  fa18 : fa port map(row10_2(7+i), row11_2(5+i), row12_2(3+i), row7_3(13+i), row8_3(12+i));
  end generate;

  add13: ha port map(row1_2(16), row2_2(15), row1_3(16), row2_3(16));
  add14: ha port map(row1_2(17), row2_2(16), row1_3(17), row2_3(17));
  add15: ha port map(row4_2(13), row5_2(11), row3_3(15), row4_3(14));
  add16: ha port map(row4_2(14), row5_2(12), row3_3(16), row4_3(15));
  add17: ha port map(row7_2(9), row8_2(7), row5_3(13), row6_3(12));
  add18: ha port map(row7_2(10), row8_2(8), row5_3(14), row6_3(13));
  add19: ha port map(row10_2(5), row11_2(3), row7_3(11), row8_3(10));
  add20: ha port map(row10_2(6), row11_2(4), row7_3(12), row8_3(11));
  
  add21: ha port map(row1_2(50), row2_2(49), row1_3(50), row2_3(50));
  add22: ha port map(row4_2(43), row5_2(41), row3_3(45), row4_3(44));
  add23: ha port map(row7_2(35), row8_2(33), row5_3(39), row6_3(38));
  add24: ha port map(row10_2(27), row11_2(25), row7_3(33), row8_3(32));

  row1_3(15 downto 0) <= row1_2(15 downto 0);
  row2_3(14 downto 0) <= row2_2(14 downto 0);
  row3_3(12 downto 0) <= row3_2(12 downto 0);
  row4_3(10 downto 0) <= row4_2(10 downto 0);
  row5_3(8 downto 0) <= row5_2(8 downto 0);
  row6_3(6 downto 0) <= row6_2(6 downto 0);
  row7_3(4 downto 0) <= row7_2(4 downto 0);
  row8_3(2 downto 0) <= row8_2(2 downto 0);
  row9_3(0) <= row9_2(0);

  row2_3(15) <= row3_2(13);
  row3_3(13) <= row4_2(11);
  row4_3(11) <= row5_2(9);
  row5_3(9) <= row6_2(7);
  row6_3(7) <= row7_2(5);
  row7_3(5) <= row8_2(3);
  row8_3(3) <= row9_2(1);
  row9_3(1) <= row10_2(0);

  row3_3(14) <= row3_2(14);
  row4_3(12) <= row4_2(12);
  row5_3(10) <= row5_2(10);
  row6_3(8) <= row6_2(8);
  row7_3(6) <= row7_2(6);
  row8_3(4) <= row8_2(4);
  row9_3(2) <= row9_2(2);
  
  row4_3(13) <= row6_2(9);
  row5_3(11) <= row7_2(7);
  row6_3(9) <= row8_2(5);
  row7_3(7) <= row9_2(3);
  row8_3(5) <= row10_2(1);
  row9_3(3) <= row11_2(0);

  row5_3(12) <= row6_2(10);
  row6_3(10) <= row7_2(8);
  row7_3(8) <= row8_2(6);
  row8_3(6) <= row9_2(4);
  row9_3(4) <= row10_2(2);
 
  row6_3(11) <= row9_2(5);
  row7_3(9) <= row10_2(3);
  row8_3(7) <= row11_2(1);
  row9_3(5) <= row12_2(0);

  row7_3(10) <= row9_2(6);
  row8_3(8) <= row10_2(4);
  row9_3(6) <= row11_2(2);
  
  row8_3(9) <= row12_2(1);
  row9_3(7) <= row13_2(0);

  row9_3(8) <= row12_2(2);
  
  row9_3(28 downto 9) <= row13_2(20 downto 1);

  row1_3(63 downto 52) <= row1_2(63 downto 52);
  row2_3(62 downto 51) <= row2_2(62 downto 51);
  row3_3(59 downto 49) <= row3_2(59 downto 49);
  row4_3(55 downto 47) <= row4_2(55 downto 47);
  row5_3(51 downto 45) <= row5_2(51 downto 45);
  row6_3(47 downto 43) <= row6_2(47 downto 43);
  row7_3(43 downto 41) <= row7_2(43 downto 41);
  row8_3(39) <= row8_2(39);

  row1_3(51) <= row1_2(51);
  row3_3(48) <= row2_2(50);
  row4_3(46) <= row3_2(48);
  row5_3(44) <= row4_2(46);
  row6_3(42) <= row5_2(44);
  row7_3(40) <= row6_2(42);
  row8_3(38) <= row7_2(40);
  row9_3(36) <= row8_2(38);
-- Gatta
  row3_3(47) <= row3_2(47);
  row4_3(45) <= row4_2(45);
  row5_3(43) <= row5_2(43);
  row6_3(41) <= row6_2(41);
  row7_3(39) <= row7_2(39);
  row8_3(37) <= row8_2(37);
  row9_3(35) <= row9_2(35);

  row3_3(46) <= row4_2(44);
  row5_3(42) <= row5_2(42);
  row6_3(40) <= row6_2(40);
  row7_3(38) <= row7_2(38);
  row8_3(36) <= row8_2(36);
  row9_3(34) <= row9_2(34);

  row5_3(41) <= row6_2(39);
  row6_3(39) <= row7_2(37);
  row7_3(37) <= row8_2(35);
  row8_3(35) <= row9_2(33);
  row9_3(33) <= row10_2(31);

  row5_3(40) <= row7_2(36);
  row7_3(36) <= row8_2(34);
  row8_3(34) <= row9_2(32);
  row9_3(32) <= row10_2(30);

  row7_3(35) <= row9_2(31);
  row8_3(33) <= row10_2(29);
  row9_3(31) <= row11_2(27);

  row7_3(34) <= row10_2(28);
  row9_3(30) <= row11_2(26);

  row9_3(29) <= row12_2(23);

  -- Fourth Stage
  gen_add9: for i in 0 to 43 generate
  fa19 : fa port map(row1_3(12+i), row2_3(11+i), row3_3(9+i), row1_4(12+i), row2_4(12+i));
  end generate;

  gen_add10: for i in 0 to 39 generate
  fa20 : fa port map(row4_3(9+i), row5_3(7+i), row6_3(5+i), row3_4(11+i), row4_4(10+i));
  end generate;

  gen_add11: for i in 0 to 35 generate
  fa21 : fa port map(row7_3(5+i), row8_3(3+i), row9_3(1+i), row5_4(9+i), row6_4(8+i));
  end generate;


  add46: ha port map(row1_3(10), row2_3(9), row1_4(10), row2_4(10));
  add25: ha port map(row1_3(11), row2_3(10), row1_4(11), row2_4(11));
  add26: ha port map(row4_3(7), row5_3(5), row3_4(9), row4_4(8));
  add27: ha port map(row4_3(8), row5_3(6), row3_4(10), row4_4(9));
  add28: ha port map(row7_3(3), row8_3(1), row5_4(7), row6_4(6));
  add29: ha port map(row7_3(4), row8_3(2), row5_4(8), row6_4(7));

  add30: ha port map(row1_3(56), row2_3(55), row1_4(56), row2_4(56));
  add31: ha port map(row4_3(49), row5_3(47), row3_4(51), row4_4(50));
  add32: ha port map(row7_3(41), row8_3(39), row5_4(45), row6_4(44));

  row1_4(9 downto 0) <= row1_3(9 downto 0);
  row2_4(8 downto 0) <= row2_3(8 downto 0);
  row3_4(6 downto 0) <= row3_3(6 downto 0);
  row4_4(4 downto 0) <= row4_3(4 downto 0);
  row5_4(2 downto 0) <= row5_3(2 downto 0);
  row6_4(0) <= row6_3(0);

  
  row1_4(63 downto 58) <= row1_3(63 downto 58);
  row2_4(62 downto 57) <= row2_3(62 downto 57);
  row3_4(59 downto 55) <= row3_3(59 downto 55);
  row4_4(55 downto 53) <= row4_3(55 downto 53);
  row5_4(51) <= row5_3(51);

  row2_4(9) <= row3_3(7);
  row3_4(7) <= row4_3(5);
  row4_4(5) <= row5_3(3);
  row5_4(3) <= row6_3(1);
  row6_4(1) <= row7_3(0);

  row3_4(8) <= row3_3(8);
  row4_4(6) <= row4_3(6);
  row5_4(4) <= row5_3(4);
  row6_4(2) <= row6_3(2);

  row4_4(7) <= row6_3(3);
  row5_4(5) <= row7_3(1);
  row6_4(3) <= row8_3(0);

  row5_4(6) <= row6_3(4);
  row6_4(4) <= row7_3(2);
--Gatta
  row6_4(5) <= row9_3(0);
  
  row1_4(57) <= row1_3(57);
  row3_4(54) <= row2_3(56);
  row4_4(52) <= row3_3(54);
  row5_4(50) <= row4_3(52);
  row6_4(48) <= row5_3(50);

  row3_4(53) <= row3_3(53);
  row4_4(51) <= row4_3(51);
  row5_4(49) <= row5_3(49);
  row6_4(47) <= row6_3(47);

  row3_4(52) <= row4_3(50);
  row5_4(48) <= row5_3(48);
  row6_4(46) <= row6_3(46);

  row5_4(47) <= row6_3(45);
  row6_4(45) <= row7_3(43);
  
  row5_4(46) <= row7_3(42);

  -- Fifth stage
  gen_add12: for i in 0 to 51 generate
  fa22 : fa port map(row1_4(8+i), row2_4(7+i), row3_4(5+i), row1_5(8+i), row2_5(8+i));
  end generate;

  gen_add13: for i in 0 to 47 generate
  fa23 : fa port map(row4_4(5+i), row5_4(3+i), row6_4(1+i), row3_5(7+i), row4_5(6+i));
  end generate;

  add33: ha port map(row1_4(6), row2_4(5), row1_5(6), row2_5(6));
  add34: ha port map(row1_4(7), row2_4(6), row1_5(7), row2_5(7));
  add35: ha port map(row4_4(3), row5_4(1), row3_5(5), row4_5(4));
  add36: ha port map(row4_4(4), row5_4(2), row3_5(6), row4_5(5));
 
  add37: ha port map(row1_4(60), row2_4(59), row1_5(60), row2_5(60));
  add38: ha port map(row4_4(53), row5_4(51), row3_5(55), row4_5(54));

  row1_5(5 downto 0) <= row1_4(5 downto 0);
  row2_5(4 downto 0) <= row2_4(4 downto 0);
  row3_5(2 downto 0) <= row3_4(2 downto 0);
  row4_5(0) <= row4_4(0);

  row1_5(63 downto 62) <= row1_4(63 downto 62);
  row2_5(62 downto 61) <= row2_4(62 downto 61);
  row3_5(59) <= row3_4(59);

  row2_5(5) <= row3_4(3);
  row3_5(3) <= row4_4(1);
  row4_5(1) <= row5_4(0);

  row3_5(4) <= row3_4(4);
  row4_5(2) <= row4_4(2);

  row4_5(3) <= row6_4(0);

  row1_5(61) <= row1_4(61);
  row3_5(58) <= row2_4(60);
  row4_5(56) <= row3_4(58);

  row3_5(57) <= row3_4(57);
  row4_5(55) <= row4_4(55);

  row3_5(56) <= row4_4(54);

  --Sixth stage

  gen_add14: for i in 0 to 55 generate
  fa24 : fa port map(row1_5(6+i), row2_5(5+i), row3_5(3+i), row1_6(6+i), row2_6(6+i));
  end generate;

  add39: ha port map(row1_5(4), row2_5(3), row1_6(4), row2_6(4));
  add40: ha port map(row1_5(5), row2_5(4), row1_6(5), row2_6(5));
  add41: ha port map(row1_5(62), row2_5(61), row1_6(62), row2_6(62));

  row1_6(3 downto 0) <= row1_5(3 downto 0);
  row2_6(2 downto 0) <= row2_5(2 downto 0);
  row3_6(0) <= row3_5(0);

  row2_6(3) <= row3_5(1);
  row3_6(1) <= row4_5(0);

  row3_6(2) <= row3_5(2);

  row3_6(58 downto 3) <= row4_5(56 downto 1);

  row1_6(63) <= row1_5(63);
  row3_6(60) <= row2_5(62);
  row3_6(59) <= row3_5(59);

  --Seventh stage
  gen_add15: for i in 0 to 59 generate
  fa25 : fa port map(row1_6(4+i), row2_6(3+i), row3_6(1+i), row1_7(4+i), row2_7(4+i));
  end generate;

  add42: ha port map(row1_6(2), row2_6(1), row1_7(2), row2_7(2));
  add43: ha port map(row1_6(3), row2_6(2), row1_7(3), row2_7(3));

  row1_7(1 downto 0) <= row1_6(1 downto 0);
  row2_7(0) <= row2_6(0);
  row2_7(1) <= row3_6(0);

-- Eigth stage
gen_add16: for i in 0 to 61 generate
  fa26 : fa port map(row1_7(2+i), row2_7(1+i), carry(1+i), product(2+i), carry(2+i));
  end generate;

  add44: ha port map(row1_7(0), row2_7(0), product(0), carry(0));
  add45: ha port map(row1_7(1), carry(0), product(1), carry(1));

  result <= product(63 downto 0);
end beh;
