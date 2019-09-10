//=========================================
// File name: riscv_alu.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: RISC-V ALU
// Project: RISC-V cpu design
//=========================================

module riscv_alu (
	in1,
	in2,
	alu_sel,
	imm,
	out
);

  //==========================================
  // Parameter
  //==========================================
  parameter DATA_WIDTH = 32;
	parameter ADD				 = 4'b0000;
	parameter SUB				 = 4'b0001;
	parameter AND				 = 4'b0010;
	parameter OR				 = 4'b0011;
	parameter XOR				 = 4'b0100;
	parameter UPPER_LOAD = 4'b0101;
	parameter SHIFT_L    = 4'b0110;
	parameter SHIFT_R		 = 4'b0111;
	parameter SHIFT_RA   = 4'b1000;

  //==========================================
  //Define port
  //==========================================
	input [DATA_WIDTH - 1 : 0] 	in1;
	input [DATA_WIDTH - 1 : 0] 	imm;
	input [DATA_WIDTH - 1 : 0] 	in2;
	input [3:0] 								alu_sel;
	output [DATA_WIDTH - 1 : 0] out;

  //==========================================
  // Internal signal
  //==========================================
	reg [DATA_WIDTH - 1 : 0] 		out_reg;

  //==========================================
  // Architecture module
  //==========================================
	always @ (*) begin
		case (alu_sel) 
			ADD:					out_reg = in1 + in2;
			SUB:					out_reg = in1 - in2;
			XOR:  				out_reg = in1 ^ in2;
			OR:						out_reg = in1 | in2;
			AND:					out_reg = in1 & in2;
			UPPER_LOAD:		out_reg = {in2[31:12],{12{1'b0}}};
			SHIFT_L:			out_reg = in2 << (imm[4:0]);
			SHIFT_R:			out_reg = in2 >> (imm[4:0]);
			SHIFT_RA:			out_reg = in2 >>> (imm[4:0]);
			default:			out_reg = 32'hz;
		endcase
	end

  //==========================================
  //output port
  //==========================================
	 assign out = out_reg;

endmodule

