library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_hazard_extension is
  port (
    clk: in std_logic;
    rst: in std_logic;
    s: in std_logic;
    rd: in std_logic_vector(4 downto 0);
    rs1: in std_logic_vector(4 downto 0);
    rs2: in std_logic_vector(4 downto 0);
    nop_enable: out std_logic    
  );
end data_hazard_extension;

architecture beh of data_hazard_extension is
  signal rd_d1: std_logic_vector(4 downto 0);
  signal rd_d2: std_logic_vector(4 downto 0);
  signal rd_d3: std_logic_vector(4 downto 0);
  
  signal out_comp1: std_logic;
  signal out_comp2: std_logic;
  signal out_comp3: std_logic;
  signal cnt_enable: std_logic;

  signal is_2: std_logic;
  signal nop_enable_tmp: std_logic;


  signal count: std_logic_vector(1 downto 0);
  --signal count: std_logic_vector(1 downto 0);

  component data_hazard_detection_unit is
    port (
      rd: in std_logic_vector(4 downto 0);
      rs1: in std_logic_vector(4 downto 0);
      rs2: in std_logic_vector(4 downto 0);
      nop_enable: out std_logic
    );
    end component;

  component sr is
    port (
      s: in std_logic;
      r: in std_logic;
      q: out std_logic);
  end component;


begin  -- beh


data_hazard_detection_unit0: data_hazard_detection_unit port map(rd_d1, rs1, rs2, out_comp1);
data_hazard_detection_unit1: data_hazard_detection_unit port map(rd_d2, rs1, rs2, out_comp2);
data_hazard_detection_unit2: data_hazard_detection_unit port map(rd_d3, rs1, rs2, out_comp3);

sr0: sr port map(cnt_enable, is_2, nop_enable_tmp);

process(clk)
begin
  if(clk = '1' AND clk'event) then
    rd_d3 <= rd_d2;
    rd_d2 <= rd_d1;
    rd_d1 <= rd;
  end if;
end process;

  cnt_enable <= out_comp1 OR out_comp2 OR out_comp3;

process(clk, rst, nop_enable_tmp)
begin
  if(rst = '0')then
    count <= "00";
  end if;

  if(clk = '1' and clk'event) then
    if(nop_enable_tmp = '1')then
        count <= count + '1';
    end if;
    if(is_2 = '1')then
      count <= "00";
    end if;
  end if;
  end process;

process(count)
begin

  if(count = "10") then
    is_2 <= '1';
  --  count <= "00";
  else
    is_2 <= '0';
  end if;
end process;

process(s, nop_enable_tmp)
begin
  if(s = '1') then
    nop_enable <= '0';
  else
    nop_enable <= nop_enable_tmp;
  end if;
end process;
end beh;