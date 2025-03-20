# Advanced ALU Project

This project implements an advanced Arithmetic Logic Unit (ALU) using SystemVerilog. It includes several operations and an advanced testbench with random tests, assertions, functional coverage, and deterministic edge tests.

## Project Overview

The ALU supports the following operations:
- **Addition (opcode 000):** a + b
- **Subtraction (opcode 001):** a - b
- **Bitwise AND (opcode 010):** a & b
- **Bitwise OR (opcode 011):** a | b
- **Multiplication (opcode 100):** a * b
- **Left Shift (opcode 101):** a <<< 1
- **Right Shift (opcode 110):** a >>> 1
- **Bitwise XOR (opcode 111):** a ^ b

The testbench includes:
- **Randomized Testing:** Generates random signed inputs for thorough testing.
- **Deterministic Edge Testing:** Uses extreme and edge values to validate critical cases.
- **Assertions:** Verifies that the ALU outputs are correct for each operation.
- **Functional Coverage:** Captures functional coverage data for each opcode.

## Files

- `advanced_alu.sv`: Contains the SystemVerilog module for the advanced ALU.
- `tb_advanced_alu.sv`: Contains the testbench for the ALU with both random and edge tests.

## How to Run the Simulation

1. Open [EDA Playground](https://www.edaplayground.com/) (or your preferred SystemVerilog simulator).
2. Choose SystemVerilog as the language.
3. Upload or paste the content of both `advanced_alu.sv` and `tb_advanced_alu.sv` (they can be in a single file or separate files depending on the tool).
4. Run the simulation.
5. The simulation output will show random test results with binary representations of inputs and outputs, as well as edge test results.

## Random Seed and Reproducibility

By default, the random tests use a fixed seed in many simulators to ensure reproducibility. If you want different random sequences for each simulation run, you may need to adjust the seed (consult your simulator documentation for details on setting the random seed).

## Project Extensions

Future improvements can include:
- **Enhanced Coverage:** For example, add cross coverage between opcode, a, and b.
- **Additional Features:** For example, implement division, bitwise NOT, and overflow/zero flags.
- **Advanced Verification:** For example, integrate UVM to build a transaction-level scoreboard.


### Contact Information
- Liron Leibovich
- LinkedIn: [Liron Leibovich](https://www.linkedin.com/in/liron-leibovich1)
- GitHub: [LironL99](https://github.com/LironL99)




