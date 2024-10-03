# 4-bit ALU Project

## Description

This module implements a 4-bit Arithmetic Logic Unit (ALU) capable of performing a variety of arithmetic and logical operations on two 4-bit input operands. The ALU is designed to support the following operations:

1. **Arithmetic Operations**:
   - **Addition**: Computes the sum of two operands, with overflow detection.
   - **Subtraction**: Calculates the difference between two operands, also including overflow detection.
   - **Increment**: Increments the first operand by one.
   - **Decrement**: Decrements the first operand by one.
   - **Less Than**: Evaluates if the first operand is less than the second, returning a boolean result.
   - **Equal**: Checks for equality between the two operands, returning a boolean result.
   - **Greater Than**: Determines if the first operand is greater than the second, returning a boolean result.

2. **Logical Operations**:
   - **AND**: Performs a bitwise AND operation on the two operands.
   - **OR**: Executes a bitwise OR operation.
   - **XOR**: Computes a bitwise exclusive OR operation.
   - **NAND**: Calculates the bitwise NAND of the two operands.
   - **NOR**: Computes the bitwise NOR operation.
   - **Bitwise NOT**: Inverts all bits of the first operand.

3. **Bit Shifting Operations**:
   - **Logical Shift Left**: Shifts the bits of the first operand to the left, filling the vacated bit positions with zeros.
   - **Logical Shift Right**: Shifts the bits of the first operand to the right, filling the vacated bit positions with zeros.
   - **Arithmetic Shift Right**: Shifts the bits of the first operand to the right, preserving the sign bit.

### Design Overview

The ALU operates based on a control signal that dictates which operation to perform. It utilizes a combinational logic design that enables real-time computation based on the input values. The design is modular, allowing for easy expansion and integration into larger systems, such as microcontrollers or FPGA-based designs.

### Applications

This 4-bit ALU can serve as a foundational component in various digital systems, including:
- Microprocessors for simple computing tasks.
- FPGA projects for educational purposes or proof-of-concept designs.
- Digital signal processing applications where basic arithmetic and logic operations are required.

Overall, this ALU module is a versatile building block for both educational and practical applications in digital design.

### Control Signals
The ALU operation is controlled using a 4-bit control signal, allowing for easy selection of operations.

### Testbench
A comprehensive testbench has been developed to validate the functionality of the ALU, covering normal cases and edge cases. The testbench provides detailed output for each operation, aiding in debugging and verification.

## Implementation
- Written in Verilog, the ALU and testbench are structured to facilitate easy modification and testing. 
- The project demonstrates fundamental digital design principles and Verilog coding practices.

## Usage
To simulate the ALU, run the `alu_4bit_tb.v` testbench in ModelSim. Ensure that the simulation environment is properly set up and the necessary libraries are loaded.

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

## Example Outputs
| Input A | Input B | Control | Result | Overflow |
|---------|---------|---------|--------|----------|
| 0001   | 0010   | 000     | 0011   | 0        |
| 0011   | 0001   | 001     | 0010   | 0        |
| 0001   | 0011   | 101     | 1100   | 0        |
| 1111   | 0001   | 000     | 0000   | 1        |  // Overflow example
| 0110   | 0010   | 1000   | 1100   | 0        |  // Logical Shift Left
| 0100   | 0001   | 1010   | 0000   | 0        |  // Arithmetic Shift Right

## Author
Liron Leibovich  
Date: 03/10/2024
