//=========================================
// File name: riscv_branch_comp.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: RISC-V BRANCH COMP
// Project: RISC-V cpu design
//=========================================

module riscv_branch_comp (
	A,
	B,
	BrUn,
	BrEq,
	BrLT
);

  //==========================================
  // Parameter
  //==========================================
	parameter DATA_WIDTH = 32;	

  //==========================================
  //Define port
  //==========================================
	input [DATA_WIDTH - 1 : 0] A;
	input [DATA_WIDTH - 1 : 0] B;
	input											 BrUn;
	output										 BrEq;
	output										 BrLT;

  //==========================================
  // Internal signal
  //==========================================
  reg 											 BrEq_reg;
	reg												 BrLT_reg;
	wire [DATA_WIDTH:0]				 A_tmp;
	wire [DATA_WIDTH:0]				 B_tmp;	

  //==========================================
  // Architecture module
  //==========================================
  assign A_tmp = {1'b0,A};
	assign B_tmp = {1'b0,B};
	always @ (*) begin
		case (BrUn)
			1'b0: begin
					if(A == B) begin
						BrEq_reg = 1'b1;
						BrLT_reg = 1'b0;
					end
					else if (A<B) begin
						BrEq_reg = 1'b0;
						BrLT_reg = 1'b1;
					end 
					else begin
						BrEq_reg = 1'b0;
						BrLT_reg = 1'b0;
					end
				end
			1'b1: begin
					if(A_tmp == B_tmp) begin
						BrEq_reg = 1'b1;
						BrLT_reg = 1'b0;
					end
					else if (A_tmp < B_tmp) begin
						BrEq_reg = 1'b0;
						BrLT_reg = 1'b1;
					end
				  else begin
						BrEq_reg = 1'b0;
						BrLT_reg = 1'b0;
					end
				end
			default: begin
						BrEq_reg = 1'bz;
						BrLT_reg = 1'bz;
				end
		endcase
	end

  //==========================================
  //output port
  //==========================================
	assign BrEq = BrEq_reg;
	assign BrLT = BrLT_reg;

endmodule

