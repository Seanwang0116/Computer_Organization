`include "Program_Counter.v"
`include "Adder.v"
`include "Instr_Memory.v"
`include "Mux2to1.v"
`include "Mux3to1.v"
`include "Reg_File.v"
`include "Decoder.v"
`include "ALU_Ctrl.v"
`include "Sign_Extend.v"
`include "Zero_Filled.v"
`include "ALU.v"
`include "Shifter.v"
`include "Data_Memory.v"

module Simple_Single_CPU (
    clk_i,
    rst_n
);

  //I/O port
  input clk_i;
  input rst_n;

  //Internal Signles
  wire [31:0] Jr_pc;
  wire [31:0] PC_o;
  wire [31:0] IM_o;
  wire [31:0] Adder1_pc;
  wire [31:0] Adder2_pc;
  wire [31:0] ex_o;
  wire [31:0] branch_pc;
  wire [31:0] zero_o;
  wire [31:0] read_data_1;
  wire [31:0] read_data_2;
  wire [31:0] write_data;
  wire [31:0] t_i;
  wire [31:0] t_o;
  wire [4:0] write_reg;
  wire [2:0] ALUOp_o;
  wire branch_t;
  wire ALUSrc_o;
  wire Jump_o;
  wire RegDst_o;
  wire Branch_o;
  wire BranchType_o;
  wire MemRead_o;
  wire MemWrite_o;
  wire MemtoReg_o;
  wire RegWrite_o;
  wire [3:0] ALU_operation_o;
  wire [1:0] FURslt_o;
  wire leftRight_o;
  wire [31:0] result;
  wire zero;
  wire overflow;
  wire [31:0] Mux3to1_o;
  wire [31:0] DM_o;


  //modules
  Program_Counter PC (
      .clk_i(clk_i),
      .rst_n(rst_n),
      .pc_in_i(Jr_pc),
      .pc_out_o(PC_o)
  );

  Adder Adder1 (
      .src1_i(PC_o),
      .src2_i(32'd4),
      .sum_o (Adder1_pc)
  );

  Adder Adder2 (
      .src1_i(Adder1_pc),
      .src2_i(ex_o << 2),
      .sum_o (Adder2_pc)
  );
  
  assign branch_t = (BranchType_o) ? ~zero : zero;

  Mux2to1 #(
      .size(32)
  ) Mux_branch (
      .data0_i (Adder1_pc),
      .data1_i (Adder2_pc),
      .select_i(Branch_o & branch_t),
      .data_o  (branch_pc)
  );

  Mux2to1 #(
      .size(32)
  ) Mux_jump (
      .data0_i (branch_pc),
      .data1_i ({Adder1_pc[31:28], IM_o[25:0], 2'b00}),
      .select_i(Jump_o),
      .data_o  (Jr_pc)
  );

  Instr_Memory IM (
      .pc_addr_i(PC_o),
      .instr_o  (IM_o)
  );

  Mux2to1 #(
      .size(5)
  ) Mux_Write_Reg (
      .data0_i (IM_o[20:16]),
      .data1_i (IM_o[15:11]),
      .select_i(RegDst_o),
      .data_o  (write_reg)
  );

  Reg_File RF (
      .clk_i(clk_i),
      .rst_n(rst_n),
      .RSaddr_i(IM_o[25:21]),
      .RTaddr_i(IM_o[20:16]),
      .RDaddr_i(write_reg),
      .RDdata_i(write_data),
      .RegWrite_i(RegWrite_o),
      .RSdata_o(read_data_1),
      .RTdata_o(read_data_2)
  );

  Decoder Decoder (
      .instr_op_i(IM_o[31:26]),
      .RegWrite_o(RegWrite_o),
      .ALUOp_o(ALUOp_o),
      .ALUSrc_o(ALUSrc_o),
      .RegDst_o(RegDst_o),
      .Jump_o(Jump_o),
      .Branch_o(Branch_o),
      .BranchType_o(BranchType_o),
      .MemRead_o(MemRead_o),
      .MemWrite_o(MemWrite_o),
      .MemtoReg_o(MemtoReg_o)
  );

  ALU_Ctrl AC (
      .funct_i(IM_o[5:0]),
      .ALUOp_i(ALUOp_o),
      .ALU_operation_o(ALU_operation_o),
      .FURslt_o(FURslt_o),
      .leftRight_o(leftRight_o)
  );

  Sign_Extend SE (
      .data_i(IM_o[15:0]),
      .data_o(ex_o)
  );

  Zero_Filled ZF (
      .data_i(IM_o[15:0]),
      .data_o(zero_o)
  );

  Mux2to1 #(
      .size(32)
  ) ALU_src2Src (
      .data0_i (read_data_2),
      .data1_i (ex_o),
      .select_i(ALUSrc_o),
      .data_o  (t_i)
  );

  ALU ALU (
      .aluSrc1(read_data_1),
      .aluSrc2(t_i),
      .ALU_operation_i(ALU_operation_o),
      .result(result),
      .zero(zero),
      .overflow(overflow)
  );

  Shifter shifter (
      .result(t_o),
      .leftRight(leftRight_o),
      .shamt(IM_o[10:6]),
      .sftSrc(t_i)
  );

  Mux3to1 #(
      .size(32)
  ) RDdata_Source (
      .data0_i (result),
      .data1_i (t_o),
      .data2_i (zero_o),
      .select_i(FURslt_o),
      .data_o  (Mux3to1_o)
  );

  Data_Memory DM (
      .clk_i(clk_i),
      .addr_i(Mux3to1_o),
      .data_i(read_data_2),
      .MemRead_i(MemRead_o),
      .MemWrite_i(MemWrite_o),
      .data_o(DM_o)
  );

  Mux2to1 #(
      .size(32)
  ) Mux_Write (
      .data0_i(Mux3to1_o),
      .data1_i(DM_o),
      .select_i(MemtoReg_o),
      .data_o(write_data)
  );

endmodule



