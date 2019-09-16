//=========================================
// File name: riscv_dmem.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: RISC-V DMEM
// Project: RISC-V cpu design
//=========================================

module riscv_dmem (
	clk,
	reset,
	mem_wen,
	addr,
	data_w,
	data_r,
	inst
);

  //==========================================
  // Parameter
  //==========================================
  parameter DLY_FF = 1;
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 15;
	parameter MEM_SIZE = 1 << (ADDR_WIDTH - 1);

  //==========================================
  //Define port
  //==========================================
  input clk;
	input reset;
	input mem_wen;
	input [DATA_WIDTH - 1 : 0] inst;
	input [ADDR_WIDTH - 1 : 0] addr;
	input [DATA_WIDTH - 1 : 0] data_w;
	output [DATA_WIDTH - 1 : 0] data_r;

  //==========================================
  // Internal signal
  //==========================================
  reg [DATA_WIDTH - 1 : 0] data_reg;
	reg [DATA_WIDTH - 1 : 0] data_w_reg;
	reg [DATA_WIDTH - 1 : 0] mem_ddata [MEM_SIZE - 1 : 0];

  //==========================================
  // Architecture module
  //==========================================
	always @ (*) begin
		if (reset == 1'b1) begin
			data_reg =  32'b0;
		end
		else if (mem_wen == 1'b1) begin
			mem_ddata[addr] =  data_w_reg;
		end
		else if (mem_wen == 1'b0) begin
			data_reg =  mem_ddata[addr];
		end	
		else begin
			data_reg = 32'bx;
		end
	end

	//==========================================
	//	Function SH,SB
	//==========================================
	always @ (*) begin
		if (inst[6:0] == 7'b010_0011) begin
			case (inst[14:12])
				3'b000: #1 data_w_reg = {{24{1'b0}},data_w[7:0]};
				3'b001: #1 data_w_reg = {{16{1'b0}},data_w[15:0]};
				3'b010: #1 data_w_reg = data_w;
				default: #1 data_w_reg = data_w;
			endcase
		end
		else begin
			#1 data_w_reg = data_w;
		end
	end

  //==========================================
  //output port
  //==========================================
	assign data_r = data_reg;

endmodule

