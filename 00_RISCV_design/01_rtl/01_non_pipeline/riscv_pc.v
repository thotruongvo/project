//=========================================
// File name: riscv_pc.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: RISC-V PC
// Project: RISC-V cpu design
//=========================================

module riscv_pc (
	clk,
	reset,
	selpc,
	d_mux_1,
	pc_4,
	pc_out
);

	//==========================================
	// Parameter
	//==========================================
	parameter DLY_FF = 1;
	
	//==========================================
	//Define port
	//==========================================
	input clk;
	input	reset;
	input selpc;
	input [31:0] d_mux_1;
	output [14:0] pc_out;
	output [14:0] pc_4;

	//==========================================
	// Internal signal
	//==========================================
	reg [31:0] pc_reg;
	reg [31:0] mux_out;

	//==========================================
	// Architecture module
	//==========================================
	always @ (posedge clk or posedge reset) begin //always for FF
		if (reset == 1'b1) begin
			pc_reg	<=	#DLY_FF 15'b0;
		end
		else begin
			pc_reg	<=	#DLY_FF mux_out;
		end
	end

	always @ (*) begin //always for mux
		if (selpc == 1'b0) begin
			mux_out = pc_reg + 15'd4;
		end
		else begin
			mux_out = d_mux_1;
		end
	end

	//==========================================
	//output port
	//==========================================
	assign pc_out = pc_reg[14:0];
	assign pc_4 = pc_reg[14:0] + 15'd4;

endmodule

