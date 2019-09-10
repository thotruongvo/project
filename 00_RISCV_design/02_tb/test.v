module test ();
  reg [31:0] in1;
  reg [31:0] in2;
  reg BrUn;

  wire eq;
  wire lt;

  riscv_branch_comp u_comp (
    .rs1 (in1),
    .rs2 (in2),
    .BrUn (BrUn),
    .BrEq (eq),
    .BrLT (lt)
  );

  initial begin
    in1 = 32'hFFFF_F000;
    in2 = 32'h0FFF_FFFF;
    BrUn = 1'b0;
    #30 BrUn = 1'b1;
    #30 in1 = 32'h9876_0000;
     in2 = 32'h9876_0000;
    #31 BrUn = 1'b0;
    #30 in1 = 32'hF876_0000;
     in2 = 32'hF876_0000;
    #31 BrUn = 1'b1;
    #30 in1 = 32'hF876_0500;
     in2 = 32'hF876_0000;
    #31 BrUn = 1'b0;
    #30 in1 = 32'hF876_0500;
     in2 = 32'hF876_A000;
    #31 BrUn = 1'b1;
    #30 in1 = 32'h0876_A000;
     in2 = 32'h0876_0000;
    #31 BrUn = 1'b0;
    #30 in1 = 32'h0876_A000;
     in2 = 32'h0876_C000;
    #31 BrUn = 1'b1;
    #50;
    #50;
  end

endmodule
