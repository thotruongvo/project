//=========================================
// File name: riscv_alumux_1.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: ALU mux 1 for RISC-V
// Project: RISC-V cpu design
//=========================================

module riscv_alumux_1 (
	pc,
	rs1,
	asel,
	alumux1_out
);

  //==========================================
  // Parameter
  //==========================================
	parameter DATA_WIDTH = 32;

  //==========================================
  //Define port
  //==========================================
	input [14 : 0]						 pc;
	input [DATA_WIDTH - 1 : 0] rs1;
	input											 asel;
	output [DATA_WIDTH - 1 : 0] alumux1_out;

  //==========================================
  // Internal signal
  //==========================================
	reg [DATA_WIDTH - 1 : 0] alu_reg;

  //==========================================
  // Architecture module
  //==========================================
	always @ (*) begin
		case (asel)
			1'b0: 		alu_reg = rs1;
			1'b1: 		alu_reg = pc;
			default: 	alu_reg = 'hz;
		endcase
	end

  //==========================================
  //output port
  //==========================================
	assign alumux1_out = alu_reg;

endmodule

