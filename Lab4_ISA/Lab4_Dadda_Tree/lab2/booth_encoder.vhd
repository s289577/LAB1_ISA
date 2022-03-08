library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity booth_encoder is
  port (
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
end booth_encoder;

architecture beh of booth_encoder is
  type t_p is array (0 to 16) of std_logic_vector(32 downto 0);

  signal p: t_p;
  signal s: std_logic_vector(16 downto 0);
  signal tmp: std_logic_vector(2 downto 0);
  signal a_1: std_logic_vector(32 downto 0);
  signal b_extended: std_logic_vector(34 downto 0);
  signal q: std_logic_vector(32 downto 0);
  signal bits: std_logic_vector(2 downto 0);

  component booth_encoder_component is
    port (
      --clk: in std_logic;
      bit1: in std_logic;
       bit2: in std_logic;
      bit3: in std_logic;
      a: in std_logic_vector(31 downto 0);
      p: out std_logic_vector(32 downto 0);
      s: out std_logic
      );
  end component;
  
 begin  -- beh
  
 a_1(32 downto 1) <= a;
 a_1(0) <= '0';

 b_extended(34) <= '0';
 b_extended(33) <= '0';
 b_extended(0) <= '0';
 b_extended(32 downto 1) <= b;
 
partial_products :  for I in 1 to 17 generate
    pp : booth_encoder_component port map(b_extended(((2*I)-2)), b_extended(2*I-1), b_extended(2*I), a, p(I-1), s(I-1));
end generate partial_products;

    p1 <= p(0);
    s1 <= s(0);
    
    p2 <= p(1);
    s2 <= s(1);
    
    p3 <= p(2);
    s3 <= s(2);
    
    p4 <= p(3);
    s4 <= s(3);
  
    p5 <= p(4);
    s5 <= s(4);
    
    p6 <= p(5);
    s6 <= s(5);
    
    p7 <= p(6);
    s7 <= s(6);
  
    p8 <= p(7);
    s8 <= s(7);
    
    p9 <= p(8);
    s9 <= s(8);
  
    p10 <= p(9);
    s10 <= s(9);
    
    p11 <= p(10);
    s11 <= s(10);

    p12 <= p(11);
    s12 <= s(11);

    p13 <= p(12);
    s13 <= s(12);
    
    p14 <= p(13);
    s14 <= s(13);
    
    p15 <= p(14);
    s15 <= s(14);
    
    p16 <= p(15);
    s16 <= s(15);
    
    p17 <= p(16)(31 downto 0);
end beh;
