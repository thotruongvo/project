//=========================================
// File name: riscv_datapath.v
// Author: Tho Vo
// Date: 27 Aug, 2019
// Description: datapath block of RISC-V
// Project: RISC-V cpu design
//=========================================

module riscv_datapath (
	clk,
	reset,
	pcsel_in,
	immsel_in,
	regwen_in,
	brun_in,
	bsel_in,
	asel_in,
	alusel_in,
	memrw_in,
	wbsel_in,
	inst_out,
	breq_out,
	brlt_out
);

  //==========================================
  // Parameter
  //==========================================
  parameter DLY_FF = 1;

  //==========================================
  //Define port
  //==========================================
	input clk;
	input reset;
	input pcsel_in;
	input memrw_in;
	input [2:0] immsel_in;
	input regwen_in;
	input brun_in;
	input bsel_in;
	input asel_in;
	input [3:0] alusel_in;
	input [1:0] wbsel_in;
	output [31:0] inst_out;
	output breq_out;
	output brlt_out;

  //==========================================
  // Internal signal
  //==========================================
	wire [31:0]	alu_w;
	wire [14:0] pc_w;
	wire [14:0]	pc_4_w;
	wire [31:0] inst_w;
	wire [31:0]	wb_w;
	wire [31:0]	rs1_w;
	wire [31:0]	rs2_w;
	wire [31:0]	imm_w;
	wire [31:0] alumux1_w;
	wire [31:0] alumux2_w;
	wire [31:0] mem_w;

  //==========================================
  // Architecture module
  //==========================================
	assign inst_out = inst_w;	
	// pc_instance
	riscv_pc u_pc (
			.clk					(clk),
			.reset				(reset),
			.selpc				(pcsel_in),
			.d_mux_1			(alu_w),
			.pc_out				(pc_w),
			.pc_4					(pc_4_w)
	);

	// imem instance
	riscv_imem u_imem (
			.reset				(reset),
			.pc						(pc_w),
			.inst					(inst_w)	
	);

	// Register instance
	riscv_register u_regs (
			.reset				(reset),
			.reg_wen			(regwen_in),
			.data_d				(wb_w),
			.addr_d				(inst_w[11:7]),
			.addr_a				(inst_w[19:15]),
			.addr_b				(inst_w[24:20]),
			.data_a				(rs1_w),
			.data_b				(rs2_w)
	);

	// imm_gen instance
	riscv_imm_gen u_imm_gen (
			.data_in			(inst_w[31:7]),
			.select				(immsel_in),
			.imm_out			(imm_w)
	);

	//branch comp instance
	riscv_branch_comp u_branch_com (
			.rs1						(rs1_w),
			.rs2						(rs2_w),
			.BrUn					(brun_in),
			.BrEq					(breq_out),
			.BrLT					(brlt_out)
	);

	// alumux_1_instance
	riscv_alumux_1 u_alumux_1 (
			.pc						(pc_w),
			.rs1					(rs1_w),
			.asel					(asel_in),
			.alumux1_out	(alumux1_w)
	);

	//alumux_2_instance
	riscv_alumux_2 u_alumux_2 (
			.imm					(imm_w),
			.rs2					(rs2_w),
			.bsel					(bsel_in),
			.alumux2_out	(alumux2_w)
	);

	// alu instance
	riscv_alu u_alu (
			.in1					(alumux1_w),
			.in2					(alumux2_w),
			.alu_sel			(alusel_in),
			.imm					(imm_w),
			.out					(alu_w)
	);

	// dmem instance
	riscv_dmem u_dmem (
			.clk					(clk),
			.reset				(reset),
			.mem_wen			(memrw_in),
			.addr					(alu_w[14:0]),
			.data_w				(rs2_w),
			.data_r				(mem_w),
			.inst					(inst_w)
	);

	//wbmux instance
	riscv_wbmux u_wbmux (
			.alu					(alu_w),
			.pc_4					(pc_4_w),
			.mem					(mem_w),
			.wbsel				(wbsel_in),
			.wb						(wb_w),
			.inst					(inst_w)
	);

  //==========================================
  //output port
  //==========================================

endmodule

