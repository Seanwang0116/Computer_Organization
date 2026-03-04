module ALU (
    aluSrc1,
    aluSrc2,
    ALU_operation_i,
    result,
    zero,
    overflow
);

  //I/O ports
  input [32-1:0] aluSrc1;
  input [32-1:0] aluSrc2;
  input [4-1:0] ALU_operation_i;

  output [32-1:0] result;
  output zero;
  output overflow;

  //Internal Signals
  wire [32-1:0] result;
  wire zero;
  wire overflow;

  assign result = (ALU_operation_i == 4'b0000) ? aluSrc1 & aluSrc2 :
    (ALU_operation_i == 4'b0001) ? aluSrc1 | aluSrc2 :
    (ALU_operation_i == 4'b0010) ? aluSrc1 + aluSrc2 : 
    (ALU_operation_i == 4'b0110) ? aluSrc1 - aluSrc2 :
    (ALU_operation_i == 4'b0111) ? $signed(aluSrc1) < $signed(aluSrc2) :
    (ALU_operation_i == 4'b1000) ? ~($signed(aluSrc1) < $signed(aluSrc2)) :
    (ALU_operation_i == 4'b1001) ? aluSrc1 << aluSrc2 :
    (ALU_operation_i == 4'b1010) ? aluSrc1 >> aluSrc2 :
    (ALU_operation_i == 4'b1100) ? ~(aluSrc1 | aluSrc2) : 32'b0;

  assign zero = (result == 32'b0);

  assign overflow = ((aluSrc1[31] == aluSrc2[31]) && (aluSrc1[31] != result[31]));
  
    


endmodule
