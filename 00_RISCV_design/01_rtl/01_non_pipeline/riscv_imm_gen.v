//=========================================
// File name: riscv_imm_gen.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: RISC-V IMM GEN
// Project: RISC-V cpu design
//=========================================

module riscv_imm_gen (
	data_in,
	select,
	imm_out
);

  //==========================================
  // Parameter
  //==========================================
	parameter DATA_WIDTH = 32;
	parameter I_TYPE = 3'b000;
	parameter S_TYPE = 3'b001;
	parameter B_TYPE = 3'b010;
	parameter U_TYPE = 3'b011;
	parameter JAL		 = 3'b100;
	parameter JALR	 = 3'b101;

  //==========================================
  //Define port
  //==========================================
	input [24:0] 								data_in;
	input [2:0] 								select;
	output [DATA_WIDTH - 1 : 0] imm_out;

  //==========================================
  // Internal signal
  //==========================================
	reg [DATA_WIDTH - 1 : 0] 		imm_reg;

  //==========================================
  // Architecture module
  //==========================================
	always @ (*) begin
		case (select) 
			I_TYPE:	 imm_reg = {{20{data_in[24]}},data_in[24:13]};
			S_TYPE:	 imm_reg = {{20{data_in[24]}},data_in[24:18],data_in[4:0]};
			B_TYPE:  imm_reg = {{20{data_in[24]}},data_in[24],data_in[0],data_in[23:18],data_in[4:1],1'b0};
			U_TYPE:  imm_reg = {{12{data_in[24]}},data_in[24:5]};
			JAL		:  imm_reg = {{11{data_in[24]}},data_in[24],data_in[12:5],data_in[13],data_in[23:14],1'b0};
			JALR	:  imm_reg = {{20{data_in[24]}},data_in[24:13]};
			default:  imm_reg = 32'bz;
		endcase
	end

  //==========================================
  //output port
  //==========================================
	assign imm_out = imm_reg;

endmodule

