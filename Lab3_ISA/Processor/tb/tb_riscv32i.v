//`timescale 1ns

module tb_riscv32i ();

   wire CLK_i;
   wire rst_n_i;
   wire [31:0] instruction_i;
   wire [31:0] address_instruction_mem_i;
   wire [31:0] read_data_mem_i;
   wire [31:0] write_data_mem_i;
   wire [31:0] address_data_mem_i;
   wire read_enable_data_memory_i;
   wire write_enable_data_memory_i;


   clk_gen CG(.CLK(CLK_i),
				.RST_N(rst_n_i));

   riscv32i UUT(.clk(CLK_i),
   .rst_n(rst_n_i),
   .instruction(instruction_i),
   .address_instruction_mem(address_instruction_mem_i),
   .read_data_mem(read_data_mem_i),
   .write_data_mem(write_data_mem_i),
   .address_data_mem(address_data_mem_i),
   .read_enable_data_memory(read_enable_data_memory_i),
   .write_enable_data_memory(write_enable_data_memory_i)
   );

   data_memory DM(.address(address_data_mem_i),
   .write_data(write_data_mem_i),
   .mem_write(write_enable_data_memory_i),
   .mem_read(read_enable_data_memory_i),
   .data(read_data_mem_i)
   );

   instruction_memory IM(
	   .address(address_instruction_mem_i),
	   .instruction(instruction_i)
   );


endmodule

		   
