//`timescale 1ns

module tb_fir ();

   wire CLK_i;
   wire [31:0] FP_A_i;
   wire [31:0] FP_B_i;
   wire [31:0] FP_Z_i;

   clk_gen CG(.CLK(CLK_i));

   data_maker SM(.CLK(CLK_i),
		 .DATA(FP_A_i)
		//.DATA(FP_B_i)
       );

   FPmul UUT(.clk(CLK_i),
	     .FP_A(FP_A_i),
		 .FP_B(FP_A_i),
		 .FP_Z(FP_Z_i));

   data_sink DS(.CLK(CLK_i),
		.DIN(FP_Z_i));   

endmodule

		   