# 4-bit ALU Project

## Description
This module implements a 4-bit ALU that performs various arithmetic and logical operations.

## Usage
To simulate the ALU, run the `alu_tb.v` testbench in ModelSim.

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
