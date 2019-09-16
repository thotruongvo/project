//=========================================
// File name: riscv_imem.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: instruction memory
// Project: RISC-V cpu design
//=========================================

module riscv_imem (
	reset,
	pc,
	inst
);

  //==========================================
  // Parameter
  //==========================================
  parameter DLY_MEM = 1;
	parameter INST_WIDTH = 32;
	parameter PC_WIDTH = 15;
	parameter MEM_SIZE = 1 << PC_WIDTH;

  //==========================================
  //Define port
  //==========================================
	input reset;
	input [PC_WIDTH - 1 : 0] pc;
	output [INST_WIDTH - 1 : 0] inst;

  //==========================================
  // Internal signal
  //==========================================
  reg [INST_WIDTH - 1 : 0] mem_data [MEM_SIZE - 1 : 0];
	reg [INST_WIDTH - 1 : 0] inst_reg;
	wire [1:0] pc_check;

	//==========================================
	initial begin
		$readmemh("./test.dat",mem_data);
	end

  //==========================================
  // Architecture module
  //==========================================
	assign pc_check = pc[1:0];
	//wire [31:0] mem_tmp;
	//assign mem_tmp = mem_data[pc]
	always @ (pc) begin
		if (pc_check == 2'b00) begin
			inst_reg	=	#DLY_MEM mem_data[pc[14:2]];
		end
		else begin
			inst_reg	=	#DLY_MEM 32'bz;
		end
	end

  //==========================================
  //output port
  //==========================================
	assign inst = inst_reg;

endmodule

