# 4-bit ALU Project

## Description
This module implements a 4-bit ALU that performs various arithmetic and logical operations.

- **Control Signals**: 
  The ALU operation is controlled using a 4-bit control signal, allowing for easy selection of operations.

- **Testbench**: 
  A comprehensive testbench has been developed to validate the functionality of the ALU, covering normal cases and edge cases. The testbench provides detailed output for each operation, aiding in debugging and verification.

## Implementation
- Written in Verilog, the ALU and testbench are structured to facilitate easy modification and testing. 
- The project demonstrates fundamental digital design principles and Verilog coding practices.

## Usage
To simulate the ALU, run the `alu_tb.v` testbench in ModelSim.

## Author
Liron Leibovich  
Date: 03/10/2024



## Example Outputs
| Input A | Input B | Control | Result | Overflow |
|---------|---------|---------|--------|----------|
| 0001   | 0010   | 000     | 0011   | 0        |
| 0011   | 0001   | 001     | 0010   | 0        |
| 0001   | 0011   | 101     | 1100   | 0        |

## Control Signal Table
| Control Signal (ctrl) | Operation          | Description                                   |
|-----------------------|--------------------|-----------------------------------------------|
| 3'b000                | Addition           | A + B                                         |
| 3'b001                | Subtraction        | A - B                                         |
| 3'b010                | AND                | A & B                                        |
| 3'b011                | OR                 | A | B                                        |
| 3'b100                | XOR                | A ^ B                                        |
| 3'b101                | NAND               | ~(A & B)                                     |
| 3'b110                | NOR                | ~(A | B)                                     |
| 3'b111                | Bitwise NOT        | ~A                                           |
| 3'b1000               | Logical Shift Left | A << 1                                       |
| 3'b1001               | Logical Shift Right| A >> 1                                       |
| 3'b1010               | Arithmetic Shift Right | A >>> 1                                   |
| 3'b1011               | Less Than          | A < B (1 if true, 0 if false)               |
| 3'b1100               | Equal              | A == B (1 if true, 0 if false)              |
| 3'b1101               | Greater Than       | A > B (1 if true, 0 if false)               |
| 3'b1110               | Increment          | A + 1                                        |
| 3'b1111               | Decrement          | A - 1                                        |
