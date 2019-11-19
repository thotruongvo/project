//==================================================================================================
//  Filename      : riscv_forwarding.v
//  Created On    : 2019-09-11 20:54:29
//  Last Modified : 2019-11-19 00:45:00
//  Revision      : 
//  Author        : Tho Vo
//  Email         : vttho1996@gmail.com
//
//  Description   : RISC-V processor design
//
//
//==================================================================================================

`define R_TYPE      7'b01100_11
`define I_TYPE      7'b00100_11
`define LOAD_TYPE   7'b00000_11
`define S_TYPE      7'b01000_11  //Store

module riscv_forwarding (/*autoport*/
//output
     forward_A,
     forward_B,
     forward_3_A,
     forward_3_B,
//input
     inst_s2,
     inst_s3,
     inst_s4,
     inst_s5
  );

  //=============================================
  // Port declare
  //=============================================
  input  [31:0] inst_s2;
  input  [31:0] inst_s3;
  input  [31:0] inst_s4;
  input  [31:0] inst_s5;
  output [1:0] forward_A;
  output       forward_3_A;
  output       forward_3_B;
  output [1:0] forward_B;

  //=============================================
  // internal signals
  //=============================================
  reg [1:0] forward_A_reg;
  reg [1:0] forward_B_reg;
  reg       forward_3_A_reg;
  reg       forward_3_B_reg;

  //=============================================
  // Architecture module 
  //=============================================
  always @ (*) begin
    if ((inst_s2[6:0] == `R_TYPE) || (inst_s2[6:0] == `I_TYPE) || (inst_s2[6:0] == `LOAD_TYPE) || (inst_s2[6:0] == `S_TYPE)) begin
        if ( 
        ((inst_s3[6:0] == `R_TYPE) && (inst_s3[11:7] == inst_s2[19:15])) || 
        ((inst_s3[6:0] == `I_TYPE) && (inst_s3[11:7] == inst_s2[19:15]))
        ) begin
          forward_A_reg = 2'b01;
        end
        else if (
        ((inst_s4[6:0] == `R_TYPE) && (inst_s4[11:7] == inst_s2[19:15])) || 
        ((inst_s4[6:0] == `I_TYPE) && (inst_s4[11:7] == inst_s2[19:15])) ||
        ((inst_s4[6:0] == `LOAD_TYPE) && (inst_s4[11:7] == inst_s2[19:15]))
        ) begin
          forward_A_reg = 2'b10;
        end
        else if (
        ((inst_s5[6:0] == `R_TYPE) && (inst_s5[11:7] == inst_s2[19:15])) || 
        ((inst_s5[6:0] == `I_TYPE) && (inst_s5[11:7] == inst_s2[19:15])) ||
        ((inst_s5[6:0] == `LOAD_TYPE) && (inst_s5[11:7] == inst_s2[19:15]))
        ) begin
          forward_A_reg = 2'b11;
    end
    else begin
          forward_A_reg = 2'b00;
    end
  end

  always @(*) begin
    if ((inst_s3[6:0] == `R_TYPE) || (inst_s3[6:0] == `I_TYPE) || (inst_s3[6:0] == `LOAD_TYPE) || (inst_s3[6:0] == `S_TYPE)) begin
       if (inst_s4[6:0] == `LOAD_TYPE) begin
          forward_3_A_reg = 1'b1;
       end
       else begin
          forward_3_A_reg = 1'b0;
       end 
    end
    else begin
          forward_3_A_reg = 1'b0;
    end
  end

  //==================================================
  //
  //==================================================
  always @ (*) begin
    if (inst_s2[6:0] == `R_TYPE || inst_s2[6:0] == `S_TYPE) begin
        if ( 
        ((inst_s3[6:0] == `R_TYPE) && (inst_s3[11:7] == inst_s2[24:20])) || 
        ((inst_s3[6:0] == `I_TYPE) && (inst_s3[11:7] == inst_s2[24:20]))
        ) begin
          forward_B_reg = 2'b01;
        end
        else if (
        ((inst_s4[6:0] == `R_TYPE) && (inst_s4[11:7] == inst_s2[24:20])) || 
        ((inst_s4[6:0] == `I_TYPE) && (inst_s4[11:7] == inst_s2[24:20])) ||
        ((inst_s4[6:0] == `LOAD_TYPE) && (inst_s4[11:7] == inst_s4[24:20]))
        ) begin
          forward_B_reg = 2'b10;
        end
        else if (
        ((inst_s5[6:0] == `R_TYPE) && (inst_s5[11:7] == inst_s2[24:20])) || 
        ((inst_s5[6:0] == `I_TYPE) && (inst_s5[11:7] == inst_s2[24:20])) ||
        ((inst_s5[6:0] == `LOAD_TYPE) && (inst_s5[11:7] == inst_s2[24:20]))
        ) begin
          forward_B_reg = 2'b11;
        end
        else begin
          forward_B_reg = 2'b00;
        end                      
    end 
    else begin
      forward_B_reg = 2'b00;
    end
  end

 ///////////////////////////////////////////
 ///////////////////////////////////
  always @ (*) begin
    if (inst_s3[6:0] == `R_TYPE || inst_s3[6:0] == `S_TYPE) begin
      if (inst_s4[6:0] == `LOAD_TYPE) begin
        forward_3_B_reg = 1'b1;
      end
      else begin
        forward_3_B_reg = 1'b0;
      end
    end
    else begin
        forward_3_B_reg = 1'b0;
    end
  end

  //=============================================
  // output port
  //=============================================
  assign forward_A = forward_A_reg;
  assign forward_B = forward_B_reg;
  assign forward_3_A = forward_3_A_reg;
  assign forward_3_B = forward_3_B_reg;

endmodule 