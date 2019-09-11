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

	//================================
	//Stage 1
	//================================
	wire [14:0] pc_4_s1;
	riscv_reg_pipe #(
			.DLY_FF 			(1),
			.DATA_WIDTH 	(15)
	) u_pc_4_s1 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_4_w),
			.reg_out			(pc_4_s1)
	);
	
	wire [14:0] pc_4_s2;
	riscv_reg_pipe #(
			.DLY_FF 			(1),
			.DATA_WIDTH 	(15)
	) u_pc_4_s2 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_4_s1),
			.reg_out			(pc_4_s2)
	);
	
	wire [14:0] pc_4_s3;
	riscv_reg_pipe #(
			.DLY_FF 			(1),
			.DATA_WIDTH 	(15)
	) u_pc_4_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_4_s2),
			.reg_out			(pc_4_s3)
	);

	wire [14:0] pc_4_s4;
	riscv_reg_pipe #(
			.DLY_FF 			(1),
			.DATA_WIDTH 	(15)
	) u_pc_4_s4 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_4_s3),
			.reg_out			(pc_4_s4)
	);

	wire [14:0] pc_4_s5;
	riscv_reg_pipe #(
			.DLY_FF 			(1),
			.DATA_WIDTH 	(15)
	) u_pc_4_s5 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_4_s4),
			.reg_out			(pc_4_s5)
	);


	//pipeline pc signal
	wire [14:0] pc_s1;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(15)
	) u_pc_s1 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_w),
			.reg_out			(pc_s1)
	);

	wire [14:0] pc_s2;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(15)
	) u_pc_s2 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_s1),
			.reg_out			(pc_s2)
	);

	wire [14:0] pc_s3;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(15)
	) u_pc_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(pc_s2),
			.reg_out			(pc_s3)
	);

	//pipeline inst gisnal
	wire [31:0] inst_s1;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_inst_s1 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(inst_w),
			.reg_out			(inst_s1)
	);

	wire [31:0] inst_s2;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_inst_s2 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(inst_s1),
			.reg_out			(inst_s2)
	);

	wire [31:0] inst_s3;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_inst_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(inst_s2),
			.reg_out			(inst_s3)
	);

	wire [31:0] inst_s4;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_inst_s4 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(inst_s3),
			.reg_out			(inst_s4)
	);

	wire [31:0] inst_s5;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_inst_s5 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(inst_s4),
			.reg_out			(inst_s5)
	);


	//pipeline rs1 and rs2
	wire [31:0] rs1_s2;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_rs1_s2 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(rs1_w),
			.reg_out			(rs1_s2)
	);

	wire [31:0] rs2_s2;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_rs2_s2 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(rs2_w),
			.reg_out			(rs2_s2)
	);

	wire [31:0] rs2_s3;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_rs2_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(rs2_s2),
			.reg_out			(rs2_s3)
	);

	wire [31:0] rs2_s4;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_rs2_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(rs2_s3),
			.reg_out			(rs2_s4)
	);

//pipe line imm signal
	wire [31:0] imm_s2;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_imm_s2 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(imm_w),
			.reg_out			(imm_s2)
	);

	wire [31:0] imm_s3;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_imm_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(imm_s2),
			.reg_out			(imm_s3)
	);

	// wire [31:0] imm_s4;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_imm_s4 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(imm_s3),
	// 		.reg_out			(imm_s4)
	// );

	//pipeline alumux signal	
	wire [31:0] alumux1_s3;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_alumux1_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(alumux1_w),
			.reg_out			(alumux1_s3)
	);

	wire [31:0] alumux2_s3;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_alumux2_s3 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(alumux2_w),
			.reg_out			(alumux2_s3)
	);

	//pipeline alu_out signal
	wire [31:0] alu_s4;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_alu_s4 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(alu_w),
			.reg_out			(alu_s4)
	);

	wire [31:0] alu_s5;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_alu_s5 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(alu_s4),
			.reg_out			(alu_s5)
	);

	// wire [31:0] alu_s3;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_alu_s3 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(alu_w),
	// 		.reg_out			(alu_s3)
	// );

	// wire [31:0] alu_s2;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_alu_s2 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(alu_s3),
	// 		.reg_out			(alu_s2)
	// );

	// wire [31:0] alu_s1;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_alu_s1 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(alu_s2),
	// 		.reg_out			(alu_s1)
	// );

	// wire [31:0] alu_s0;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_alu_s0 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(alu_s1),
	// 		.reg_out			(alu_s0)
	// );

	//pipeline MEM	
	wire [31:0] mem_s5;
	riscv_reg_pipe #(
			.DLY_FF				(1),
			.DATA_WIDTH		(32)
	) u_mem_s5 (
			.clk					(clk),
			.reset				(reset),
			.enable				(1'b1),
			.reg_in				(mem_w),
			.reg_out			(mem_s5)
	);

	//pipeline wb output
	// wire [31:0] wb_s5;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_wb_s5 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(wb_w),
	// 		.reg_out			(wb_s5)
	// );

	// wire [31:0] wb_s4;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_wb_s4 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(wb_s5),
	// 		.reg_out			(wb_s4)
	// );

	// wire [31:0] wb_s3;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_wb_s3 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(wb_s4),
	// 		.reg_out			(wb_s3)
	// );

	// wire [31:0] wb_s2;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_wb_s2 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(wb_s3),
	// 		.reg_out			(wb_s2)
	// );

	// wire [31:0] wb_s1;
	// riscv_reg_pipe #(
	// 		.DLY_FF				(1),
	// 		.DATA_WIDTH		(32)
	// ) u_wb_s1 (
	// 		.clk					(clk),
	// 		.reset				(reset),
	// 		.enable				(1'b1),
	// 		.reg_in				(wb_s2),
	// 		.reg_out			(wb_s1)
	// );

//========================================================

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
			.addr_d				(inst_s5[11:7]),
			.addr_a				(inst_s1[19:15]),
			.addr_b				(inst_s1[24:20]),
			.data_a				(rs1_w),
			.data_b				(rs2_w)
	);

	// imm_gen instance
	riscv_imm_gen u_imm_gen (
			.data_in			(inst_s1[31:7]),
			.select				(immsel_in),
			.imm_out			(imm_w)
	);

	//branch comp instance
	riscv_branch_comp u_branch_com (
			.A						(rs1_w),
			.B						(rs2_w),
			.BrUn					(brun_in),
			.BrEq					(breq_out),
			.BrLT					(brlt_out)
	);

	// alumux_1_instance
	riscv_alumux_1 u_alumux_1 (
			.pc						(pc_s2),
			.rs1					(rs1_s2),
			.asel					(asel_in),
			.alumux1_out	(alumux1_w)
	);

	//alumux_2_instance
	riscv_alumux_2 u_alumux_2 (
			.imm					(imm_s2),
			.rs2					(rs2_s2),
			.bsel					(bsel_in),
			.alumux2_out	(alumux2_w)
	);

	// alu instance
	riscv_alu u_alu (
			.in1					(alumux1_s3),
			.in2					(alumux2_s3),
			.alu_sel			(alusel_in),
			.imm					(imm_s3),
			.out					(alu_w)
	);

	// dmem instance
	riscv_dmem u_dmem (
			.clk					(clk),
			.reset				(reset),
			.mem_wen			(memrw_in),
			.addr					(alu_s4[14:0]),
			.data_w				(rs2_s4),
			.data_r				(mem_w),
			.inst					(inst_s4)
	);

	//wbmux instance
	riscv_wbmux u_wbmux (
			.alu					(alu_s5),
			.pc_4					(pc_4_s5),
			.mem					(mem_s5),
			.wbsel				(wbsel_in),
			.wb						(wb_w),
			.inst					(inst_s5)
	);

  //==========================================
  //output port
  //==========================================

endmodule

