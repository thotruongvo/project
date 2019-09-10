//=========================================
// File name: riscv_alumux_1.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: ALU mux 2 for RISC-V
// Project: RISC-V cpu design
//=========================================

module riscv_alumux_2 (
	imm,
	rs2,
	bsel,
	alumux2_out
);

  //==========================================
  // Parameter
  //==========================================
	parameter DATA_WIDTH = 32;

  //==========================================
  //Define port
  //==========================================
	input [DATA_WIDTH - 1 : 0] imm;
	input [DATA_WIDTH - 1 : 0] rs2;
	input											 bsel;
	output [DATA_WIDTH - 1 : 0] alumux2_out;

  //==========================================
  // Internal signal
  //==========================================
	reg [DATA_WIDTH - 1 : 0] alu_reg;

  //==========================================
  // Architecture module
  //==========================================
	always @ (*) begin
		case (bsel)
			1'b0: 		alu_reg = rs2;
			1'b1: 		alu_reg = imm;
			default: 	alu_reg = 'hz;
		endcase
	end

  //==========================================
  //output port
  //==========================================
	assign alumux2_out = alu_reg;

endmodule

