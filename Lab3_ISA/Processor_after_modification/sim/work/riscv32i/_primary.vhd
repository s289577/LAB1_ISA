library verilog;
use verilog.vl_types.all;
entity riscv32i is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        instruction     : in     vl_logic_vector(31 downto 0);
        address_instruction_mem: out    vl_logic_vector(31 downto 0);
        read_data_mem   : in     vl_logic_vector(31 downto 0);
        write_data_mem  : out    vl_logic_vector(31 downto 0);
        address_data_mem: out    vl_logic_vector(31 downto 0);
        read_enable_data_memory: out    vl_logic;
        write_enable_data_memory: out    vl_logic
    );
end riscv32i;
