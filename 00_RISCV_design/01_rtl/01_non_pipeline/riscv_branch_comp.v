//=============================================
// File name: riscv_branch_comp.v
// Author: Tho Vo
// Project: RISCV design
//=============================================

module riscv_branch_comp (
  rs1,
  rs2,
  BrUn,
  BrEq,
  BrLT
);

  //===========================================
  // Port declare
  //===========================================
  input [31:0] rs1;
  input [31:0] rs2;
  input BrUn;
  output BrEq;
  output BrLT;

  wire sign_xor;
  wire [32:0] result;
  wire [32:0] rs1_sign_ext;
  wire [32:0] rs2_sign_ext;
  assign rs1_sign_ext = {rs1[31],rs1};
  assign rs2_sign_ext = {rs2[31],rs2};
  assign result = rs1_sign_ext - rs2_sign_ext;

  assign sign_xor = rs1[31] ^ rs2[31]; 


  assign BrEq = ((rs1^rs2) == 32'd0) ? 1'b1 : 1'b0 ;
  
  reg BrLT_reg;
  always @ (*) begin
    case (BrUn)
      1'b1: begin
            if (rs1 < rs2) begin
              BrLT_reg = 1'b1;
            end
            else begin
              BrLT_reg = 1'b0;
            end
        end
      1'b0: begin
            if ((sign_xor == 1'b1) && (rs1[31] == 1'b0)) begin
              BrLT_reg = 1'b0;
            end
            else if ((sign_xor == 1'b1) && (rs1[31] == 1'b1)) begin
              BrLT_reg = 1'b1;
            end
            else if (BrEq == 1'b0) begin
              BrLT_reg = result[32];
            end
            else begin
              BrLT_reg = 1'b0;
            end
        end
      default: BrLT_reg = 1'bx;
    endcase
  end

  assign BrLT = BrLT_reg;

endmodule
