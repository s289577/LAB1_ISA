library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

--library std;
--use std.textio.all;

entity riscv32i is
  port (
    clk : in std_logic;
    rst_n: in std_logic;

    instruction : in std_logic_vector(31 downto 0);
    address_instruction_mem : out std_logic_vector(31 downto 0);

    read_data_mem : in std_logic_vector(31 downto 0);
    write_data_mem : out std_logic_vector(31 downto 0);

    address_data_mem : out std_logic_vector(31 downto 0);

    read_enable_data_memory : out std_logic;
    write_enable_data_memory : out std_logic
    );
end riscv32i;

architecture beh of riscv32i is

  -- FETCH
  signal input_pc: std_logic_vector(31 downto 0);
  signal output_pc: std_logic_vector(31 downto 0);
  signal output_pc_id: std_logic_vector(31 downto 0);
  signal output_pc_ex: std_logic_vector(31 downto 0);

  signal add_sum_if: std_logic_vector(31 downto 0);

  signal add_sum_id: std_logic_vector(31 downto 0);
  signal add_sum_ex: std_logic_vector(31 downto 0);

  signal zero_ex: std_logic;
  signal zero_mem: std_logic;

  signal m_id: std_logic;
  signal m_ex: std_logic;
  signal m_mem: std_logic;
  
  signal sel_mux_if: std_logic;

  signal add_sum_sum_ex: std_logic_vector(31 downto 0);
  signal add_sum_sum_mem: std_logic_vector(31 downto 0);
  signal add_sum_sum_wb: std_logic_vector(31 downto 0);

  --DECODE

  signal instruction_id: std_logic_vector(31 downto 0); -- 0000000 11111 11111 000 11111 0000000

  signal write_data_id: std_logic_vector(31 downto 0);
  signal write_data_ex: std_logic_vector(31 downto 0);

  signal write_register_id: std_logic_vector(4 downto 0);
  signal write_register_ex: std_logic_vector(4 downto 0);
  signal write_register_mem: std_logic_vector(4 downto 0);
  signal write_register_wb: std_logic_vector(4 downto 0); 

  signal read_data_1_id: std_logic_vector(31 downto 0)  ;
  signal read_data_2_id: std_logic_vector(31 downto 0)  ;
  signal read_data_1_ex: std_logic_vector(31 downto 0)  ;
  signal read_data_2_ex: std_logic_vector(31 downto 0)  ;
  signal read_data_2_mem: std_logic_vector(31 downto 0)  ;

  signal immediate_id: std_logic_vector(31 downto 0)  ;
  signal immediate_ex: std_logic_vector(31 downto 0)  ;

  signal branch_id: std_logic;
  signal mem_read_id: std_logic;
  signal mem_to_reg_id: std_logic_vector(1 downto 0)  ;
  signal alu_op_sel_id: std_logic_vector(2 downto 0)  ;
  signal mem_write_id: std_logic;
  signal alu_src_id: std_logic_vector(1 downto 0)  ;
  signal reg_write_id: std_logic;

  signal branch_ex: std_logic;
  signal mem_read_ex: std_logic;
  signal mem_to_reg_ex: std_logic_vector(1 downto 0)  ;
  signal alu_op_sel_ex: std_logic_vector(2 downto 0)  ;
  signal mem_write_ex: std_logic;
  signal alu_src_ex: std_logic_vector(1 downto 0)  ;
  signal reg_write_ex: std_logic;

  signal branch_mem: std_logic;
  signal mem_read_mem: std_logic;
  signal mem_write_mem: std_logic;
  signal mem_to_reg_mem: std_logic_vector(1 downto 0)  ;
  signal reg_write_mem: std_logic;

  signal mem_to_reg_wb: std_logic_vector(1 downto 0)  ;
  signal reg_write_wb: std_logic; 

  --EXECUTE

  signal alu_result_ex: std_logic_vector(31 downto 0)  ;
  signal alu_result_mem: std_logic_vector(31 downto 0)  ;
  signal alu_result_wb: std_logic_vector(31 downto 0)  ;
  signal alu_zero_ex: std_logic;
  signal alu_zero_mem: std_logic;

  signal floating: std_logic_vector(31 downto 0) ;
  signal mux41_e_ex: std_logic_vector(31 downto 0)  ;

  --WB
  signal read_data_wb: std_logic_vector(31 downto 0)  ;


  --POST
  signal nop_enable_id: std_logic;
  signal pipe_flush_pc: std_logic;
  signal pipe_flush: std_logic;

  component mux21 is
    port (
      s : in std_logic; 
      a : in std_logic_vector(31 downto 0);
      b : in std_logic_vector(31 downto 0);
      c : out std_logic_vector(31 downto 0)
    );
  end component;

  component add is
    port (
      a: in std_logic_vector(31 downto 0);
      sum: out std_logic_vector(31 downto 0)
      );
  end component;

  component add_sum is
    port (
      a: in std_logic_vector(31 downto 0);
      b: in std_logic_vector(31 downto 0);
      sum: out std_logic_vector(31 downto 0)
      );
  end component;

  component registers is
    port (
      clk : in std_logic;
      rst : in std_logic;
      reg_write : in std_logic; -- write enable
      read_register_1 : in std_logic_vector(4 downto 0); -- address rs 1
      read_register_2 : in std_logic_vector(4 downto 0); -- address rs 2
      write_register : in std_logic_vector(4 downto 0); -- address rd
      write_data : in std_logic_vector(31 downto 0); -- data to write
      read_data_1 : out std_logic_vector(31 downto 0); -- data in rs1
      read_data_2 : out std_logic_vector(31 downto 0) -- data in rs2 
      );
  end component;

  component imm_gen is
    port (
      inst: in std_logic_vector(31 downto 0);
      immediate: out std_logic_vector(31 downto 0)
      );
  end component;

  component control_unit is
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
  end component;

  component alu is
    port (
      alu_op_sel: in std_logic_vector(2 downto 0);
      a: in std_logic_vector(31 downto 0);
      b: in std_logic_vector(31 downto 0);
      alu_result: out std_logic_vector(31 downto 0);
      zero: out std_logic
      );
  end component;

  component mux41 is
    port (
      s : in std_logic_vector(1 downto 0); 
      a : in std_logic_vector(31 downto 0);
      b : in std_logic_vector(31 downto 0);
      c : in std_logic_vector(31 downto 0);
      d : in std_logic_vector(31 downto 0);
      e : out std_logic_vector(31 downto 0)
    );
  end component;

  component data_hazard_extension is
    port (
      clk: in std_logic;
      rst: in std_logic;
      s: in std_logic;
      rd: in std_logic_vector(4 downto 0);
      rs1: in std_logic_vector(4 downto 0);
      rs2: in std_logic_vector(4 downto 0);
      nop_enable: out std_logic    
    );
  end component;

begin  -- beh



-- FETCH

mux0 : mux21 port map(sel_mux_if, add_sum_if, add_sum_sum_mem, input_pc);

process(clk, rst_n, nop_enable_id, pipe_flush_pc)
begin
  if(rst_n = '0') then
    output_pc <= x"003FFFFC";
	floating <= x"FFFFFFFF";
  end if;

  if(clk = '1' and clk'event) then
    if(nop_enable_id = '0') then
      if(pipe_flush_pc = '1') then
        output_pc <= (others => '0');
      else
        output_pc <= input_pc;
      end if;
    end if;
  end if;
end process;

add0 : add port map(output_pc, add_sum_if);

address_instruction_mem <= output_pc;

-- IF/ID
process(clk, rst_n, pipe_flush)
begin
  if(pipe_flush = '1' or rst_n = '0') then
    add_sum_id <= (others => '0');
    output_pc_id <= (others => '0');
    instruction_id <= "00000001111111111000111110000000";
  else
    if(clk = '1' and clk'event) then
      add_sum_id <= add_sum_if;

      output_pc_id <= output_pc;
      instruction_id <= instruction;
    end if;
  end if;
end process;

-- DECODE

write_register_id <= instruction_id(11 downto 7);

register_file : registers port map(clk, rst_n, reg_write_mem, instruction_id(19 downto 15), instruction_id(24 downto 20), write_register_mem, write_data_id, read_data_1_id, read_data_2_id);

imm_gen0 : imm_gen port map(instruction_id, immediate_id);

control_unit0: control_unit port map(instruction_id(6 downto 0), instruction_id(14 downto 12), branch_id, mem_read_id,  reg_write_id, alu_op_sel_id, mem_write_id, alu_src_id, mem_to_reg_id);

data_hazard0: data_hazard_extension port map(clk, rst_n, sel_mux_if, write_register_id, instruction_id(19 downto 15), instruction_id(24 downto 20), nop_enable_id);


-- ID/EX
process(clk, rst_n, pipe_flush)
begin
  if(pipe_flush = '1' or rst_n = '0') then
    add_sum_ex <= (others => '0');

    branch_ex <= '0';
    mem_read_ex <= '0';
    mem_to_reg_ex <= (others => '0');
    alu_op_sel_ex <= (others => '0');
    mem_write_ex <= '0';
    alu_src_ex <= (others => '0');
    reg_write_ex <= '0';
  
    output_pc_ex <= (others => '0');
    
    read_data_1_ex <= (others => '0');
    read_data_2_ex <= (others => '0');
  
    immediate_ex <= (others => '0');
    
    write_register_ex <= (others => '0');

    else
      if(clk = '1' and clk' event) then
          add_sum_ex <= add_sum_id;

          branch_ex <= branch_id;
          mem_read_ex <= mem_read_id;
          mem_to_reg_ex <= mem_to_reg_id;
          alu_op_sel_ex <= alu_op_sel_id;
          mem_write_ex <= mem_write_id;
          alu_src_ex <= alu_src_id;
          reg_write_ex <= reg_write_id;

          output_pc_ex <= output_pc_id;
          
          read_data_1_ex <= read_data_1_id;
          read_data_2_ex <= read_data_2_id;

          immediate_ex <= immediate_id;
          
          write_register_ex <= write_register_id;
        end if;
end if;
end process;

-- EXECUTE
add_sum0: add_sum port map(output_pc_ex, immediate_ex, add_sum_sum_ex);

alu0: alu port map(alu_op_sel_ex, read_data_1_ex, mux41_e_ex, alu_result_ex, alu_zero_ex);

mux41_0: mux41 port map(alu_src_ex, read_data_2_ex, immediate_ex, add_sum_ex, floating, mux41_e_ex);

pipe_flush_pc <= alu_zero_ex and branch_ex;

-- EX/MEM
process(clk, rst_n)
begin
if(rst_n = '0') then
    branch_mem <= '0';
    mem_read_mem <= '0';
    mem_to_reg_mem <= (Others => '0');
    mem_write_mem <= '0';
    reg_write_mem <= '0';

    add_sum_sum_mem <= (Others => '0');

    alu_zero_mem <= '0';
    alu_result_mem <= (Others => '0');

    read_data_2_mem <= (Others => '0');

    write_register_mem <= (Others => '0');
end if;

if(clk = '1' and clk' event) then
    branch_mem <= branch_ex;
    mem_read_mem <= mem_read_ex;
    mem_to_reg_mem <= mem_to_reg_ex;
    mem_write_mem <= mem_write_ex;
    reg_write_mem <= reg_write_ex;

    add_sum_sum_mem <= add_sum_sum_ex;

    alu_zero_mem <= alu_zero_ex;
    alu_result_mem <= alu_result_ex;

    read_data_2_mem <= read_data_2_ex;

    write_register_mem <= write_register_ex;
end if;
end process;

-- MEMORIZATION
sel_mux_if <= branch_mem AND alu_zero_mem;
pipe_flush <= sel_mux_if;

address_data_mem <= alu_result_mem;
write_data_mem <= read_data_2_mem;
read_enable_data_memory <= mem_read_mem;
write_enable_data_memory <= mem_write_mem;

-- MEM/WB
process(clk, rst_n)
begin
if(rst_n = '0') then
  mem_to_reg_wb <= (Others => '0');
  reg_write_wb <= '0';

  write_register_wb <= (Others => '0'); 

  add_sum_sum_wb <= (Others => '0');

  read_data_wb <= (Others => '0');
  
  alu_result_wb <= (Others => '0');
end if;

if(clk = '1' and clk' event) then
  mem_to_reg_wb <= mem_to_reg_mem;
  reg_write_wb <= reg_write_mem;

  write_register_wb <= write_register_mem; 

  add_sum_sum_wb <= add_sum_sum_mem;

  read_data_wb <= read_data_mem;
  
  alu_result_wb <= alu_result_mem;
end if;
end process;

-- WRITE BACK
mux41_2 : mux41 port map(mem_to_reg_mem, alu_result_mem, read_data_mem, add_sum_sum_mem, floating, write_data_id); 
end beh;
