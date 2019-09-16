//=========================================
// File name: riscv_register.v
// Author: Tho Vo
// Date: 26 Aug, 2019
// Description: RISC-V registers
// Project: RISC-V cpu design
//=========================================

module riscv_register (
	reset,
	reg_wen,
	data_d,
	addr_a,
	addr_b,
	addr_d,
	data_a,
	data_b
);

  //==========================================
  // Parameter
  //==========================================
  parameter DLY = 1;
	parameter DATA_WIDTH = 32;
	parameter NUM_REGISTER = 32;
	localparam SEL_WIDTH = 5; 

  //==========================================
  //Define port
  //==========================================
	input reset;
	input reg_wen;
	input [SEL_WIDTH - 1 : 0] addr_a;
	input [SEL_WIDTH - 1 : 0] addr_b;
	input [SEL_WIDTH - 1 : 0] addr_d;
	input [DATA_WIDTH - 1 : 0] data_d;
	output [DATA_WIDTH - 1 : 0] data_a;
	output [DATA_WIDTH - 1 : 0] data_b;

  //==========================================
  // Internal signal
  //==========================================
	reg [DATA_WIDTH - 1 : 0] register [NUM_REGISTER - 1 : 0];
	reg [DATA_WIDTH - 1 : 0] data_a_reg;
	reg [DATA_WIDTH - 1 : 0] data_b_reg;

  //=========================================
	initial begin
		register[0] = 0;
	end
	wire [31:0] r0;
	assign r0 = register[0];
	wire [31:0] r1;
	assign r1 = register[1];
	wire [31:0] r2;
	assign r2 = register[2];
	wire [31:0] r3;
	assign r3 = register[3];
	wire [31:0] r4;
	assign r4 = register[4];
	wire [31:0] r5;
	assign r5 = register[5];
	wire [31:0] r6;
	assign r6 = register[6];
	wire [31:0] r7;
	assign r7 = register[7];
	wire [31:0] r8;
	assign r8 = register[8];
	wire [31:0] r9;
	assign r9 = register[9];
	wire [31:0] r10;
	assign r10 = register[10];
	wire [31:0] r11;
	assign r11 = register[11];
	wire [31:0] r12;
	assign r12 = register[12];
	wire [31:0] r13;
	assign r13 = register[13];
	wire [31:0] r14;
	assign r14 = register[14];
	wire [31:0] r15;
	assign r15 = register[15];
	wire [31:0] r16;
	assign r16 = register[16];
	wire [31:0] r17;
	assign r17 = register[17];
	wire [31:0] r18;
	assign r18 = register[18];
	wire [31:0] r19;
	assign r19 = register[19];
	wire [31:0] r20;
	assign r20 = register[20];
	wire [31:0] r21;
	assign r21 = register[21];
	wire [31:0] r22;
	assign r22 = register[22];
	wire [31:0] r23;
	assign r23 = register[23];
	wire [31:0] r24;
	assign r24 = register[24];
	wire [31:0] r25;
	assign r25 = register[25];
	wire [31:0] r26;
	assign r26 = register[26];
	wire [31:0] r27;
	assign r27 = register[27];
	wire [31:0] r28;
	assign r28 = register[28];
	wire [31:0] r29;
	assign r29 = register[29];
	wire [31:0] r30;
	assign r30 = register[30];
	wire [31:0] r31;
	assign r31 = register[31];
	
  //==========================================
  // Architecture module
  //==========================================

	// read/write register
reg [4:0] addr_d_reg;
always #1 addr_d_reg = addr_d; //this signal used to avoid racing time
	always @(reset or addr_d_reg) begin
		if (reset == 1'b0) begin
			if ( (reg_wen == 1'b1) && (addr_d_reg != 0) ) begin
				register[addr_d_reg] =  data_d;
			end
		end
	end

	always @(reset or addr_a or addr_b) begin
		if (reset == 1'b0) begin
			data_a_reg = register[addr_a];
			data_b_reg = register[addr_b];
		end
		else begin
			data_a_reg = 32'd0;
			data_b_reg = 32'd0;
		end
	end

  //==========================================
  //output port
  //==========================================
	assign data_a = data_a_reg;
	assign data_b = data_b_reg;

endmodule

