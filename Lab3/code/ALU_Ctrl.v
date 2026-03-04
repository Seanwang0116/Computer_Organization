module ALU_Ctrl (
    funct_i,
    ALUOp_i,
    ALU_operation_o,
    FURslt_o,
    leftRight_o
);

  //I/O ports
  input [6-1:0] funct_i;
  input [3-1:0] ALUOp_i;

  output [4-1:0] ALU_operation_o;
  output [2-1:0] FURslt_o;
  output leftRight_o;

  //Internal Signals
  wire [4-1:0] ALU_operation_o;
  wire [2-1:0] FURslt_o;
  wire leftRight_o;

 parameter R_type = 3'b010;
 parameter addi = 3'b011;
 parameter lw_sw  = 3'b000;
 parameter beq  = 3'b001;
 parameter bne_bnez  = 3'b110;
 parameter blt  = 3'b100;
 parameter bgez = 3'b101;

 parameter ADD = 6'b100011;
 parameter SUB = 6'b010011;
 parameter AND = 6'b011111;
 parameter OR  = 6'b101111;
 parameter NOR = 6'b010000;
 parameter SLT = 6'b010100;
 parameter SLLV = 6'b011000;
 parameter SLL = 6'b010010;
 parameter SRLV = 6'b101000;
 parameter SRL = 6'b100010;
 parameter JR = 6'b000001;

  assign ALU_operation_o = ({ALUOp_i,funct_i} == {R_type, ADD} || ALUOp_i == addi || ALUOp_i == lw_sw) ? 4'b0010 :
    ({ALUOp_i,funct_i} == {R_type, SUB} || ALUOp_i == beq || ALUOp_i == bne_bnez) ? 4'b0110 :
    ({ALUOp_i,funct_i} == {R_type, SLT} || ALUOp_i == blt) ? 4'b0111 :
    ({ALUOp_i,funct_i} == {R_type, NOR}) ? 4'b1100 :
    ({ALUOp_i,funct_i} == {R_type, AND} || {ALUOp_i,funct_i} == {R_type, SLL}) ? 4'b0000 :
    ({ALUOp_i,funct_i} == {R_type, OR} || {ALUOp_i,funct_i} == {R_type, SRL}) ? 4'b0001 :
    ({ALUOp_i,funct_i} == {R_type, SLLV}) ? 4'b1001 :
    ({ALUOp_i,funct_i} == {R_type, SRLV}) ? 4'b1010 :
    (ALUOp_i == bgez) ? 4'b1000 : 4'b0000;

  assign FURslt_o = ({ALUOp_i,funct_i} == {R_type, SRLV} || {ALUOp_i,funct_i} == {R_type, SRL} || {ALUOp_i,funct_i} == {R_type, SLLV} || {ALUOp_i,funct_i} == {R_type, SLL}) ? 2'b01 : 2'b00;

  assign leftRight_o = ~({ALUOp_i,funct_i} == {R_type, SRL} || {ALUOp_i,funct_i} == {R_type, SRLV});

endmodule