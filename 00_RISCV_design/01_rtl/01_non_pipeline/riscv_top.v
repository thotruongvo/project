//=========================================
// File name: riscv_top.v
// Author: Tho Vo
// Date: 27 Aug, 2019
// Description: RISC-V top
// Project: RISC-V cpu design
//=========================================

module riscv_top (clk, reset);

  //==========================================
  // Parameter
  //==========================================
  

  //==========================================
  //Define port
  //==========================================
	input clk;
	input reset;

  //==========================================
  // Internal signal
  //==========================================
	wire pcsel_w;
	wire [31:0]	inst_w;
	wire [2:0]	immsel_w;
	wire regwen_w;
	wire BrUn_w;
	wire BrEq_w;
	wire BrLT_w;
	wire BSel_w;
	wire ASel_w;
	wire [3:0] ALUSel_w;
	wire MemRW_w;
	wire [1:0] WBSel;

  //==========================================
  // Architecture module
  //==========================================
	
	//riscv_datapath instance
	riscv_datapath u_datapath (
			.clk					(clk),
  		.reset				(reset),
  		.pcsel_in			(pcsel_w),
  		.immsel_in		(immsel_w),
  		.regwen_in		(regwen_w),
  		.brun_in			(BrUn_w),
  		.bsel_in			(BSel_w),
  		.asel_in			(ASel_w),
  		.alusel_in		(ALUSel_w),
  		.memrw_in			(MemRW_w),
  		.wbsel_in			(WBSel),
  		.inst_out			(inst_w),
  		.breq_out			(BrEq_w),
  		.brlt_out			(BrLT_w)
	);

	//riscv_controller instance
	riscv_controller u_control (
			.inst					(inst_w),
			.BrEq					(BrEq_w),
			.BrLT					(BrLT_w),
			.PCSel				(pcsel_w),
			.ImmSel				(immsel_w),
			.RegWEn				(regwen_w),
			.BrUn					(BrUn_w),
			.Bsel					(BSel_w),
			.Asel					(ASel_w),
			.ALUSel				(ALUSel_w),
			.MemRW				(MemRW_w),
			.DataIn				(),
			.DataOutAddrj	(),
			.WBSel				(WBSel)

	);

  //==========================================
  //output port
  //==========================================

endmodule

