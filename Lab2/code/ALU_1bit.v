`include "Full_adder.v"
module ALU_1bit (
    a,
    b,
    invertA,
    invertB,
    operation,
    carryIn,
    less,
    result,
    carryOut
);

  //I/O ports
  input a;
  input b;
  input invertA;
  input invertB;
  input [2-1:0] operation;
  input carryIn;
  input less;

  output result;
  output carryOut;

  //Internal Signals
  wire result;
  wire carryOut;

  wire A_out, B_out, sum_out;

  assign A_out = invertA ? ~a : a;
  assign B_out = invertB ? ~b : b;

  Full_adder adder(
      .carryIn(carryIn),
      .input1(A_out),
      .input2(B_out),
      .sum(sum_out),
      .carryOut(carryOut)
  );

  assign result = (operation == 2'b0) ? A_out & B_out :
    (operation == 2'b10) ? A_out | B_out :
    (operation == 2'b11) ? sum_out :
    (operation == 2'b01) ? less : 1'b0;
 

endmodule
