library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity mbe_multiplier is
  port (
    clk: in std_logic;
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    result: out std_logic_vector(63 downto 0)
    );
end mbe_multiplier;

architecture beh of mbe_multiplier is

      signal p1: std_logic_vector(32 downto 0);
      signal p2: std_logic_vector(32 downto 0);
      signal  p3: std_logic_vector(32 downto 0);
      signal  p4: std_logic_vector(32 downto 0);
      signal p5: std_logic_vector(32 downto 0);
      signal  p6: std_logic_vector(32 downto 0);
      signal  p7: std_logic_vector(32 downto 0);
      signal   p8: std_logic_vector(32 downto 0);
      signal   p9: std_logic_vector(32 downto 0);
      signal   p10: std_logic_vector(32 downto 0);
      signal   p11: std_logic_vector(32 downto 0);
      signal  p12: std_logic_vector(32 downto 0);
      signal  p13: std_logic_vector(32 downto 0);
      signal  p14: std_logic_vector(32 downto 0);
      signal  p15: std_logic_vector(32 downto 0);
      signal  p16: std_logic_vector(32 downto 0);
      signal  p17: std_logic_vector(31 downto 0);
      
      signal s1: std_logic;
      signal  s2: std_logic;
      signal  s3: std_logic;
      signal  s4: std_logic;
      signal  s5: std_logic;
      signal s6: std_logic;
      signal  s7: std_logic;
      signal  s8: std_logic;
      signal  s9: std_logic;
      signal  s10: std_logic;
      signal  s11: std_logic;
      signal  s12: std_logic;
      signal  s13: std_logic;
      signal  s14: std_logic;
      signal  s15: std_logic;
      signal  s16: std_logic;

    --Input registers
      signal a_reg: std_logic_vector(31 downto 0);
      signal b_reg: std_logic_vector(31 downto 0);

      --BE to DT registers
      signal p1_reg: std_logic_vector(32 downto 0);
      signal p2_reg: std_logic_vector(32 downto 0);
      signal  p3_reg: std_logic_vector(32 downto 0);
      signal  p4_reg: std_logic_vector(32 downto 0);
      signal p5_reg: std_logic_vector(32 downto 0);
      signal  p6_reg: std_logic_vector(32 downto 0);
      signal  p7_reg: std_logic_vector(32 downto 0);
      signal   p8_reg: std_logic_vector(32 downto 0);
      signal   p9_reg: std_logic_vector(32 downto 0);
      signal   p10_reg: std_logic_vector(32 downto 0);
      signal   p11_reg: std_logic_vector(32 downto 0);
      signal  p12_reg: std_logic_vector(32 downto 0);
      signal  p13_reg: std_logic_vector(32 downto 0);
      signal  p14_reg: std_logic_vector(32 downto 0);
      signal  p15_reg: std_logic_vector(32 downto 0);
      signal  p16_reg: std_logic_vector(32 downto 0);
      signal  p17_reg: std_logic_vector(31 downto 0);
      
      signal s1_reg: std_logic;
      signal  s2_reg: std_logic;
      signal  s3_reg: std_logic;
      signal  s4_reg: std_logic;
      signal  s5_reg: std_logic;
      signal s6_reg: std_logic;
      signal  s7_reg: std_logic;
      signal  s8_reg: std_logic;
      signal  s9_reg: std_logic;
      signal  s10_reg: std_logic;
      signal  s11_reg: std_logic;
      signal  s12_reg: std_logic;
      signal  s13_reg: std_logic;
      signal  s14_reg: std_logic;
      signal  s15_reg: std_logic;
      signal  s16_reg: std_logic;

      --Output registers
      signal result_reg : std_logic_vector(63 downto 0); 

    component booth_encoder is
    port (
      clk: in std_logic;
      a: in std_logic_vector(31 downto 0);
      b: in std_logic_vector(31 downto 0);
      p1: out std_logic_vector(32 downto 0);
      p2: out std_logic_vector(32 downto 0);
      p3: out std_logic_vector(32 downto 0);
      p4: out std_logic_vector(32 downto 0);
      p5: out std_logic_vector(32 downto 0);
      p6: out std_logic_vector(32 downto 0);
      p7: out std_logic_vector(32 downto 0);
      p8: out std_logic_vector(32 downto 0);
      p9: out std_logic_vector(32 downto 0);
      p10: out std_logic_vector(32 downto 0);
      p11: out std_logic_vector(32 downto 0);
      p12: out std_logic_vector(32 downto 0);
      p13: out std_logic_vector(32 downto 0);
      p14: out std_logic_vector(32 downto 0);
      p15: out std_logic_vector(32 downto 0);
      p16: out std_logic_vector(32 downto 0);
      p17: out std_logic_vector(31 downto 0);
      
      s1: out std_logic;
      s2: out std_logic;
      s3: out std_logic;
      s4: out std_logic;
      s5: out std_logic;
      s6: out std_logic;
      s7: out std_logic;
      s8: out std_logic;
      s9: out std_logic;
      s10: out std_logic;
      s11: out std_logic;
      s12: out std_logic;
      s13: out std_logic;
      s14: out std_logic;
      s15: out std_logic;
      s16: out std_logic
      );
  end component;
  
  component dadda_tree is
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
  
      result: out std_logic_vector(63 downto 0));
  end component;

  begin
  a_reg <= a;
  b_reg <= b;

  p1_reg <= p1;
  p2_reg <= p2;
  p3_reg <= p3;
  p4_reg <= p4;
  p5_reg <= p5;
  p6_reg <= p6;
  p7_reg <= p7;
  p8_reg <= p8;
  p9_reg <= p9;
  p10_reg <= p10;
  p11_reg <= p11;
  p12_reg <= p12;
  p13_reg <= p13;
  p14_reg <= p14;
  p15_reg <= p15;
  p16_reg <= p16;
  p17_reg <= p17;
  s1_reg <= s1;
  s2_reg <= s2;
  s3_reg <= s3;
  s4_reg <= s4;
  s5_reg <= s5;
  s6_reg <= s6;
  s7_reg <= s7;
  s8_reg <= s8;
  s9_reg <= s9;
  s10_reg <= s10;
  s11_reg <= s11;
  s12_reg <= s12;
  s13_reg <= s13;
  s14_reg <= s14;
  s15_reg <= s15;
  s16_reg <= s16;

  result <= result_reg;

  be: booth_encoder port map(clk, a_reg, b_reg, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, 
                                    s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16);
  dt: dadda_tree port map(p1_reg, p2_reg, p3_reg, p4_reg, p5_reg, p6_reg, p7_reg, p8_reg, p9_reg, p10_reg, p11_reg, p12_reg, p13_reg, p14_reg, p15_reg, p16_reg, p17_reg, 
                                    s1_reg, s2_reg, s3_reg, s4_reg, s5_reg, s6_reg, s7_reg, s8_reg, s9_reg, s10_reg, s11_reg, s12_reg, s13_reg, s14_reg, s15_reg, s16_reg, result_reg);
            
end beh;
