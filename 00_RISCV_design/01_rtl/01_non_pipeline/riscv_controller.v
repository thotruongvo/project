//====================================
//File name: riscv_controller.v
//Author: Tho Vo
//Date: 27 Aug, 2019
//Description: Controller for RISC-V CPU
//====================================
`define NOP    32'h0000_0013
`define ADD 	 32'b?_0???????????????_000?????_0_110011
`define SUB 	 32'b?_1???????????????_000?????_0_110011
`define SLL 	 32'b?_0???????????????_001?????_0_110011
`define SLT 	 32'b?_0???????????????_010?????_0_110011
`define SLTU 	 32'b?_0???????????????_011?????_0_110011
`define XOR 	 32'b?_0???????????????_100?????_0_110011
`define SRL 	 32'b?_0???????????????_101?????_0_110011
`define SRA 	 32'b?_0???????????????_101?????_0_110011
`define OR 	 32'b?_0???????????????_110?????_0_110011
`define AND 	 32'b?_0???????????????_111?????_0_110011
`define ADDI 	 32'b?????????????????_000?????_0_010011
`define SLTI 	 32'b?????????????????_010?????_0_010011
`define SLTIU 	 32'b?????????????????_011?????_0_010011
`define XORI 	 32'b?????????????????_100?????_0_010011
`define ORI 	 32'b?????????????????_110?????_0_010011
`define ANDI 	 32'b?????????????????_111?????_0_010011
`define SLLI 	 32'b?_0???????????????_001?????_0_010011
`define SRLI 	 32'b?_0???????????????_101?????_0_010011
`define SRAI 	 32'b?_0???????????????_101?????_0_010011
`define LB 	 32'b?????????????????_000?????_0_000011
`define LH 	 32'b?????????????????_010?????_0_000011
`define LW 	 32'b?????????????????_011?????_0_000011
`define LBU 	 32'b?????????????????_100?????_0_000011
`define LHU 	 32'b?????????????????_110?????_0_000011
`define SB 	 32'b?????????????????_000?????_0_100011
`define SH 	 32'b?????????????????_001?????_0_100011
`define SW 	 32'b?????????????????_010?????_0_100011
`define BEQ 	 32'b?????????????????_000?????_1_100011
`define BNE 	 32'b?????????????????_001?????_1_100011
`define BLT 	 32'b?????????????????_100?????_1_100011
`define BGE 	 32'b?????????????????_101?????_1_100011
`define BLTU 	 32'b?????????????????_110?????_1_100011
`define BGEU 	 32'b?????????????????_111?????_1_100011
`define JAL 	 32'b?????????????????_????????_1_101111
`define JALR 	 32'b?????????????????_000?????_1_100111
`define LUI 	 32'b?????????????????_????????_0_110111
`define AUIPC 	 32'b?????????????????_????????_0_010111
module riscv_controller(
inst,
BrEq,
BrLT,
PCSel,
ImmSel,
RegWEn,
BrUn,
Bsel,
Asel,
ALUSel,
MemRW,
DataIn,
DataOutAddrj,
WBSel
);
	input [31:0] inst;
	input  BrEq;
	input  BrLT;
	output PCSel;
	reg PCSel_reg;
	output [2:0] ImmSel;
	reg [2:0] ImmSel_reg;
	output RegWEn;
	reg RegWEn_reg;
	output BrUn;
	reg BrUn_reg;
	output Bsel;
	reg Bsel_reg;
	output Asel;
	reg Asel_reg;
	output [3:0] ALUSel;
	reg [3:0] ALUSel_reg;
	output MemRW;
	reg MemRW_reg;
	output [31:0] DataIn;
	reg [31:0] DataIn_reg;
	output [31:0] DataOutAddrj;
	reg [31:0] DataOutAddrj_reg;
	output [1:0] WBSel;
	reg [1:0] WBSel_reg;
	 always @ (*) begin
		 casez(inst)
		 		`NOP: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b0;
				 BrUn_reg = 1'b0;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'b0;
				 DataOutAddrj_reg = 32'b0;
				 WBSel_reg = 2'b01;
			  end
			 `ADD: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SUB: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0001;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SLL: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0010;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SLT: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0011;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SLTU: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0100;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `XOR: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0101;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SRL: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0110;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SRA: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0111;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `OR: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b1000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `AND: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'bxxx;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b0;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b1001;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `ADDI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SLTI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SLTIU: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `XORI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0100;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `ORI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0011;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `ANDI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0010;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SLLI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0110;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SRLI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0111;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `SRAI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b1000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `LB: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'b0;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b00;
			  end
			 `LH: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'b0;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b00;
			  end
			 `LW: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'b0;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b00;
			  end
			 `LBU: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'b0;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b00;
			  end
			 `LHU: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b000;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'b0;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b00;
			  end
			 `SB: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b001;
				 RegWEn_reg = 1'b0;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b1;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'bz;
			  end
			 `SH: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b001;
				 RegWEn_reg = 1'b0;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b1;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'bz;
			  end
			 `SW: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b001;
				 RegWEn_reg = 1'b0;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b1;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'bz;
			  end
			 `BEQ: begin
				 if (BrEq == 1'b1) begin
					 PCSel_reg = 1'b1;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
				 else begin
					 PCSel_reg = 1'b0;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
			  end
			 `BNE: begin
				 if (BrEq == 1'b0) begin
					 PCSel_reg = 1'b1;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
				 else begin
					 PCSel_reg = 1'b0;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
			  end
			 `BLT: begin
				 if (BrLT == 1'b0) begin
					 PCSel_reg = 1'b0;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
				 else begin
					 PCSel_reg = 1'b1;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
			  end
			 `BGE: begin
				 if ((BrEq == 1'b1) || ((BrLT == 1'b0) && (BrEq == 0))) begin
					 PCSel_reg = 1'b1;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
				 else begin
					 PCSel_reg = 1'b0;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b0;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
			  end
			 `BLTU: begin
				 if (BrLT == 1'b0) begin
					 PCSel_reg = 1'b1;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b1;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
				 else begin
					 PCSel_reg = 1'b0;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b1;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
			  end
			 `BGEU: begin
				 if ((BrEq == 1'b1) || ((BrLT == 1'b0) && (BrEq == 0))) begin
					 PCSel_reg = 1'b1;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b1;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
				 else begin
					 PCSel_reg = 1'b0;
					 ImmSel_reg = 3'b010;
					 RegWEn_reg = 1'b0;
					 BrUn_reg = 1'b1;
					 Bsel_reg = 1'b1;
					 Asel_reg = 1'b1;
					 ALUSel_reg = 4'b0000;
					 MemRW_reg = 1'b0;
					 DataIn_reg = 32'bx;
					 DataOutAddrj_reg = 32'bx;
					 WBSel_reg = 2'bz;
				 end
			  end
			 `JAL: begin
				 PCSel_reg = 1'b1;
				 ImmSel_reg = 3'b100;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b1;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b10;
			  end
			 `JALR: begin
				 PCSel_reg = 1'b1;
				 ImmSel_reg = 3'b101;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b0;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b10;
			  end
			 `LUI: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b011;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'bx;
				 ALUSel_reg = 4'b0101;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			 `AUIPC: begin
				 PCSel_reg = 1'b0;
				 ImmSel_reg = 3'b011;
				 RegWEn_reg = 1'b1;
				 BrUn_reg = 1'bx;
				 Bsel_reg = 1'b1;
				 Asel_reg = 1'b1;
				 ALUSel_reg = 4'b0000;
				 MemRW_reg = 1'b0;
				 DataIn_reg = 32'bx;
				 DataOutAddrj_reg = 32'bx;
				 WBSel_reg = 2'b01;
			  end
			default: begin
				 PCSel_reg = 32'hz;
				 ImmSel_reg = 32'hz;
				 RegWEn_reg = 32'hz;
				 BrUn_reg = 32'hz;
				 Bsel_reg = 32'hz;
				 Asel_reg = 32'hz;
				 ALUSel_reg = 32'hz;
				 MemRW_reg = 32'hz;
				 DataIn_reg = 32'hz;
				 DataOutAddrj_reg = 32'hz;
				 WBSel_reg = 32'hz;
			end
		 endcase
 end
assign PCSel = PCSel_reg;
assign ImmSel = ImmSel_reg;
assign RegWEn = RegWEn_reg;
assign BrUn = BrUn_reg;
assign Bsel = Bsel_reg;
assign Asel = Asel_reg;
assign ALUSel = ALUSel_reg;
assign MemRW = MemRW_reg;
assign DataIn = DataIn_reg;
assign DataOutAddrj = DataOutAddrj_reg;
assign WBSel = WBSel_reg;
endmodule
