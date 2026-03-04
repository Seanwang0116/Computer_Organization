`include "ALU_1bit.v"
module ALU (
    aluSrc1,
    aluSrc2,
    invertA,
    invertB,
    operation,
    result,
    zero,
    overflow
);

  //I/O ports
  input [32-1:0] aluSrc1;
  input [32-1:0] aluSrc2;
  input invertA;
  input invertB;
  input [2-1:0] operation;

  output [32-1:0] result;
  output zero;
  output overflow;

  //Internal Signals
  wire [32-1:0] result;
  wire zero;
  wire overflow;

  wire [31:0] carryOut;
  wire set, tmp;
  assign tmp = aluSrc1[31] ^ (~aluSrc2[31]);
  assign set = tmp ^ carryOut[31];

  ALU_1bit alu0 (
      .a(aluSrc1[0]),
      .b(aluSrc2[0]),
      .invertA(invertA),
      .invertB(invertB),
      .operation(operation),
      .carryIn(invertB),
      .less(set),
      .result(result[0]),
      .carryOut(carryOut[0])
  );

  ALU_1bit alus[30:0] (
      .a(aluSrc1[31:1]),
      .b(aluSrc2[31:1]),
      .invertA(invertA),
      .invertB(invertB),
      .operation(operation),
      .carryIn(carryOut[30:0]),
      .less(1'b0),
      .result(result[31:1]),
      .carryOut(carryOut[31:1])
  );

  assign zero = (result == 32'b0) ? 1'b1 : 1'b0;
  assign overflow = (carryOut[30] == carryOut[31]) ? 1'b0 : 1'b1;
  
endmodule

