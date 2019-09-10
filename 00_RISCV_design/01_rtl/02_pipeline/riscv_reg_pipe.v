//=========================================
// File name: riscv_reg_pipe.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: Register for pipeline RISC-V
// Project: RISC-V cpu design
//=========================================

module riscv_reg_pipe (
	clk,
	reset,
	reg_in,
	reg_out,
	enable
);

  //==========================================
  // Parameter
  //==========================================
  parameter DLY_FF     = 1;
	parameter DATA_WIDTH = 32;
  //==========================================
  //Define port
  //==========================================
	input 											clk;
	input												reset;
	input												enable;
	input  [DATA_WIDTH - 1 : 0]	reg_in;
	output [DATA_WIDTH - 1 : 0]	reg_out;

  //==========================================
  // Internal signal
  //==========================================
	reg [DATA_WIDTH - 1 : 0]	data_reg;

  //==========================================
  // Architecture module
  //==========================================
	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			data_reg <= #DLY_FF {DATA_WIDTH{1'b0}};
		end
		else if (enable == 1'b1) begin
			data_reg <= #DLY_FF reg_in;
		end
		else begin

		end
	end

  //==========================================
  //output port
  //==========================================
	assign reg_out = data_reg;

endmodule

