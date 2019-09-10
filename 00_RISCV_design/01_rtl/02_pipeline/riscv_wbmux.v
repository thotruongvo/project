//=========================================
// File name: riscv_wbmux.v
// Author: Tho Vo
// Date: 27 Aug, 2019
// Description: MUX for WB module
// Project: RISC-V cpu design
//=========================================

module riscv_wbmux (
	alu,
	pc_4,
	mem,
	wbsel,
	wb,
	inst
);

  //==========================================
  // Parameter
  //==========================================
	parameter DATA_WIDTH = 32;

  //==========================================
  //Define port
  //==========================================
	input [DATA_WIDTH - 1 : 0] 	alu;
	input [DATA_WIDTH - 1 : 0]	inst;
	input [14 : 0]						 	pc_4;
	input [DATA_WIDTH - 1 : 0] 	mem;
	input [1:0]								 	wbsel;
	output [DATA_WIDTH - 1 : 0]	wb;

  //==========================================
  // Internal signal
  //==========================================
	reg 	[DATA_WIDTH - 1 : 0] 	mux_reg;
	reg		[DATA_WIDTH - 1 : 0]	mem_reg;

  //==========================================
  // Architecture module
  //==========================================
	always @ (*) begin
		case(wbsel)
			2'b00: mux_reg = mem_reg;
			2'b01: mux_reg = alu;
			2'b10: mux_reg = {17'b0,pc_4};
			default: mux_reg = 'hz;
		endcase
	end

	//==========================================
	// Function LH,LB,LHU,LBU
	//==========================================
	always @ (*) begin
		if (inst[6:0] == 7'b000_0011) begin
			case (inst[14:12])
				3'b000:		mem_reg = {{24{mem[7]}},mem[7:0]};
				3'b010:		mem_reg = {{16{mem[15]}},mem[15:0]};
				3'b011:		mem_reg = mem;
				3'b100:   mem_reg = {{24{1'b0}},mem[7:0]};
				3'b110:		mem_reg = {{16{1'b0}},mem[15:0]};
				default: mem_reg = mem;
			endcase
		end
		else begin
			mem_reg = mem;
		end
	end

  //==========================================
  //output port
  //==========================================
	assign wb = mux_reg;

endmodule

