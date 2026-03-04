# Computer Organization Labs

This repository contains the source code and design files for the Computer Organization course laboratories. The projects evolve from MIPS assembly programming to the design and implementation of a 5-stage Pipelined CPU using Verilog in the **Xilinx Vivado** environment.

## Project Structure

### Lab 1: MIPS Assembly Programming
* **Objective**: Learn MIPS instruction set architecture (ISA) and the translation between C/C++ and assembly.
* **Key Tasks**:
    * `prime.s`: Checks if a number is prime.
    * `calculator.s`: A simple arithmetic calculator.
    * `triangle.s`: Draws triangle patterns based on input.
    * `fibonacci.s`: Computes Fibonacci numbers using recursion.
* **Tools**: SPIM Simulator.

---

### Lab 2: ALU and Shifter Design
* **Objective**: Design a 32-bit ALU and Shifter using gate-level combinational logic.
* **Key Components**:
    * `ALU_1bit.v`: Building block for the 32-bit ALU.
    * `ALU.v`: Supports `AND`, `OR`, `ADD`, `SUB`, `NOR`, `NAND`, and `SLT`.
    * `Shifter.v`: Supports logical left/right shifts.
* **Tools**: Vivado (Behavioral Simulation).

---

### Lab 3: Single-Cycle CPU
* **Objective**: Implement a complete single-cycle MIPS CPU capable of executing R-type, I-type, and Jump instructions.
* **Supported Instructions**:
    * **R-type**: `add`, `sub`, `and`, `or`, `nor`, `slt`, `sll`, `srl`, `jr`, etc.
    * **I-type**: `addi`, `lw`, `sw`, `beq`, `bne`, `blt`, `bnez`, `bgez`.
    * **J-type**: `jump`, `jal`.



---

### Lab 4: 5-Stage Pipelined CPU
* **Objective**: Transform the single-cycle processor into a pipelined architecture to improve throughput.
* **Stages**: 
    1.  **IF** (Instruction Fetch)
    2.  **ID** (Instruction Decode)
    3.  **EX** (Execute)
    4.  **MEM** (Memory Access)
    5.  **WB** (Write Back)
* **Key Implementation**: 
    * Insertion of Pipeline Registers (`Pipe_Reg.v`) between stages to store data and control signals.
    * Registers are updated on the positive clock edge.

---

## Development Environment
* **Software**: Xilinx Vivado Design Suite.
* **Hardware Description Language**: Verilog HDL.
* **Simulator**: Vivado Simulator (XSim).
