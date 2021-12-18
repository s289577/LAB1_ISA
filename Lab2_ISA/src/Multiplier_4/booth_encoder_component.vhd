library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity booth_encoder_component is
  port (
   -- clk: in std_logic;
    bit1: in std_logic;
    bit2: in std_logic;
    bit3: in std_logic;
    a: in std_logic_vector(31 downto 0);

    p: out std_logic_vector(32 downto 0);
    s: out std_logic
    );
end booth_encoder_component;

architecture beh of booth_encoder_component is
  signal b_xor : std_logic_vector(32 downto 0) := (others => '0');   
  signal q : std_logic_vector(32 downto 0) := (others => '0');   
  signal a_2 : std_logic_vector(32 downto 0) := (others => '0');   
  signal a_bis : std_logic_vector(32 downto 0) := (others => '0');

   begin  -- beh 
      b_xor <= (others => bit3);
      a_2(32 downto 1) <= a;
      a_2(0) <= '0';
      a_bis(31 downto 0) <= a;
      a_bis(32) <= '0';

      q <= (others => '0') when ((NOT(bit2 XOR bit1) AND NOT(bit3 XOR bit2)) = '1') else
           a_bis when (((bit2 xor bit1)) = '1') else 
           a_2;

      p <= b_xor XOR q;
      s <= bit3;
  end beh;
