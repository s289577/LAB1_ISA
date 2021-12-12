library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myfilter is
port (
  CLK: in std_logic;
  RST_N: in std_logic;
  VIN: in std_logic;
  VOUT: out std_logic;

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
 
  DIN: in  std_logic_vector(10 downto 0);
  DOUT: out std_logic_vector(10 downto 0)
  );
end myfilter;

architecture beh of myfilter is

type t_reg_data is array (0 to 10) of signed(10 downto 0);
type t_coeff is array (0 to 10) of signed(10 downto 0);
type t_mult is array (0 to 10) of signed(10 downto 0);

signal reg_coeff : t_coeff ;
signal reg_data : t_reg_data;
signal reg_mult : t_mult;
signal reg_add: signed(10 downto 0) := (others=>'0');
signal vin_sampled: std_logic := '0';
signal vin_tmp1: std_logic := '0';
signal vin_tmp2: std_logic := '0';

begin
get_inputs : process (CLK, RST_N, VIN)

begin	-- clear registers on reset input and get data otherwise
  if(RST_N ='0') then
    reg_data <= (others=>(others=>'0'));
    reg_coeff <= (others=>(others=>'0'));
	 
  elsif(CLK'event and CLK = '1') then
   vin_sampled <= VIN;
   reg_data(10)  <= reg_data(9);
   reg_data(9)  <= reg_data(8);
   reg_data(8)  <= reg_data(7);
   reg_data(7)  <= reg_data(6);
   reg_data(6)  <= reg_data(5);
   reg_data(5)  <= reg_data(4);
   reg_data(4)  <= reg_data(3);
   reg_data(3)  <= reg_data(2);
   reg_data(2)  <= reg_data(1);
    reg_data(1)  <= reg_data(0);
    reg_data(0)  <= signed(DIN);
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
  end if;
end process get_inputs;

mult : process (CLK, RST_N, vin_sampled)	-- Compute products
begin
  if(RST_N = '0') then
    reg_mult <= (others=>(others=>'0'));
	 
  elsif(CLK'event and CLK = '1') then
    for i in 0 to 10 loop
        reg_mult(i) <= resize(shift_right(signed(reg_data(i) * reg_coeff(i)),10),11); 
    end loop;
    vin_tmp1 <= vin_sampled;
  end if;
end process mult;

add : process (CLK, RST_N, vin_tmp1)	-- Compute the sum of products
begin
  if(RST_N = '0') then
    reg_add <= (others=>'0');
	 
  elsif(CLK'event and CLK = '1') then
    reg_add <= reg_mult(0) + reg_mult(1) + reg_mult(2) + reg_mult(3) + reg_mult(4) +reg_mult(5) + reg_mult(6) +reg_mult(7) + reg_mult(8) + reg_mult(9) + reg_mult(10);
    vin_tmp2 <= vin_tmp1;
  end if;
end process add;

get_outputs : process (CLK, RST_N, vin_tmp2) -- Get the outputs
begin
  if(RST_N = '0') then
    DOUT <= (others=>'0');
	  VOUT <= '0';
	 
  elsif(CLK'event and CLK = '1') then
    DOUT <= std_logic_vector(reg_add);
	 VOUT <= vin_tmp2;
  end if;
end process get_outputs;
end beh;