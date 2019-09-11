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

	//pipeline control signal
	wire [2:0] immsel_s1;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(3)
	) u_immsel_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(immsel_w),
			.reg_out		(immsel_s1)
	);

//===================
// ASel signal
	wire ASel_s1;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_ASel_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(ASel_w),
			.reg_out		(ASel_s1)
	);

	wire ASel_s2;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_ASel_s2 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(ASel_s1),
			.reg_out		(ASel_s2)
	);

	// wire ASel_s3;
	// riscv_reg_pipe #(
	// 		.DLY_FF 		(1),
	// 		.DATA_WIDTH	(1)
	// ) u_ASel_s3 (
	// 		.clk				(clk),
	// 		.reset			(reset),
	// 		.enable			(1'b1),
	// 		.reg_in			(ASel_s2),
	// 		.reg_out		(ASel_s3)
	// );

//===================
// BSel signal
	wire BSel_s1;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_BSel_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(BSel_w),
			.reg_out		(BSel_s1)
	);

	wire BSel_s2;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_BSel_s2 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(BSel_s1),
			.reg_out		(BSel_s2)
	);

	// wire BSel_s3;
	// riscv_reg_pipe #(
	// 		.DLY_FF 		(1),
	// 		.DATA_WIDTH	(1)
	// ) u_BSel_s3 (
	// 		.clk				(clk),
	// 		.reset			(reset),
	// 		.enable			(1'b1),
	// 		.reg_in			(BSel_s2),
	// 		.reg_out		(BSel_s3)
	// );

//================================
// ALUSel signal

	wire [3:0] ALUSel_s1;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(4)
	) u_ALUSel_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(ALUSel_w),
			.reg_out		(ALUSel_s1)
	);

	wire [3:0] ALUSel_s2;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(4)
	) u_ALUSel_s2 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(ALUSel_s1),
			.reg_out		(ALUSel_s2)
	);

	wire [3:0] ALUSel_s3;
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(4)
	) u_ALUSel_s3 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(ALUSel_s2),
			.reg_out		(ALUSel_s3)
	);

	// wire [3:0] ALUSel_s4;
	// riscv_reg_pipe #(
	// 		.DLY_FF 		(1),
	// 		.DATA_WIDTH	(4)
	// ) u_ALUSel_s4 (
	// 		.clk				(clk),
	// 		.reset			(reset),
	// 		.enable			(1'b1),
	// 		.reg_in			(ALUSel_s3),
	// 		.reg_out		(ALUSel_s4)
	// );

//============================
// MemRW
	wire MemRW_s1;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_memrw_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(MemRW_w),
			.reg_out		(MemRW_s1)
	);

	wire MemRW_s2;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_memrw_s2 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(MemRW_s1),
			.reg_out		(MemRW_s2)
	);

	wire MemRW_s3;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_memrw_s3 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(MemRW_s2),
			.reg_out		(MemRW_s3)
	);

	wire MemRW_s4;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_memrw_s4 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(MemRW_s3),
			.reg_out		(MemRW_s4)
	);

	// wire MemRW_s5;		
	// riscv_reg_pipe #(
	// 		.DLY_FF 		(1),
	// 		.DATA_WIDTH	(1)
	// ) u_memrw_s5 (
	// 		.clk				(clk),
	// 		.reset			(reset),
	// 		.enable			(1'b1),
	// 		.reg_in			(MemRW_s4),
	// 		.reg_out		(MemRW_s5)
	// );

//============================
// WBSel
	wire [1:0] WBSel_s1;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(2)
	) u_wbsel_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(WBSel),
			.reg_out		(WBSel_s1)
	);

	wire [1:0] WBSel_s2;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(2)
	) u_wbsel_s2 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(WBSel_s1),
			.reg_out		(WBSel_s2)
	);

	wire [1:0] WBSel_s3;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(2)
	) u_wbsel_s3 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(WBSel_s2),
			.reg_out		(WBSel_s3)
	);

	wire [1:0] WBSel_s4;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(2)
	) u_wbsel_s4 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(WBSel_s3),
			.reg_out		(WBSel_s4)
	);

	wire [1:0] WBSel_s5;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(2)
	) u_wbsel_s5 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(WBSel_s4),
			.reg_out		(WBSel_s5)
	);

	// wire [1:0] WBSel_s6;		
	// riscv_reg_pipe #(
	// 		.DLY_FF 		(1),
	// 		.DATA_WIDTH	(2)
	// ) u_wbsel_s6 (
	// 		.clk				(clk),
	// 		.reset			(reset),
	// 		.enable			(1'b1),
	// 		.reg_in			(WBSel_s5),
	// 		.reg_out		(WBSel_s6)
	// );

//============================
// REGWEN
	wire regwen_s1;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_regwen_s1 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(regwen_w),
			.reg_out		(regwen_s1)
	);

	wire regwen_s2;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_regwen_s2 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(regwen_s1),
			.reg_out		(regwen_s2)
	);

	wire regwen_s3;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_regwen_s3 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(regwen_s2),
			.reg_out		(regwen_s3)
	);

	wire regwen_s4;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_regwen_s4 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(regwen_s3),
			.reg_out		(regwen_s4)
	);

	wire regwen_s5;		
	riscv_reg_pipe #(
			.DLY_FF 		(1),
			.DATA_WIDTH	(1)
	) u_regwen_s5 (
			.clk				(clk),
			.reset			(reset),
			.enable			(1'b1),
			.reg_in			(regwen_s4),
			.reg_out		(regwen_s5)
	);

	// wire regwen_s6;		
	// riscv_reg_pipe #(
	// 		.DLY_FF 		(1),
	// 		.DATA_WIDTH	(1)
	// ) u_regwen_s6 (
	// 		.clk				(clk),
	// 		.reset			(reset),
	// 		.enable			(1'b1),
	// 		.reg_in			(regwen_s5),
	// 		.reg_out		(regwen_s6)
	// );

///////////////////////

	//riscv_datapath instance
	riscv_datapath u_datapath (
			.clk					(clk),
  		.reset				(reset),
  		.pcsel_in			(pcsel_w),
  		.immsel_in		(immsel_s1),
  		.regwen_in		(regwen_s5),
  		.brun_in			(BrUn_w),
  		.bsel_in			(BSel_s2),
  		.asel_in			(ASel_s2),
  		.alusel_in		(ALUSel_s3),
  		.memrw_in			(MemRW_s4),
  		.wbsel_in			(WBSel_s5),
  		.inst_out			(inst_w),
  		.breq_out			(BrEq_w),
  		.brlt_out			(BrLT_w)
	);

	
  //==========================================
  //output port
  //==========================================

endmodule

