# RISC-V Single Cycle CPU Project

## Table of Contents

1. [Project Overview](#project-overview)
2. [What is RISC-V and How It Compares to CISC](#what-is-risc-v-and-how-it-compares-to-cisc)
3. [Single Cycle vs Pipelined Architecture](#single-cycle-vs-pipelined-architecture)
4. [Features and Instruction Support](#features-and-instruction-support)
5. [Module Overview](#module-overview)
   - [Program Counter (PC)](#program-counter-pc)
   - [PC Adder](#pc-adder)
   - [Instruction Memory](#instruction-memory)
   - [Register File](#register-file)
   - [Immediate Generator](#immediate-generator)
   - [Main Control Unit](#main-control-unit)
   - [ALU Control](#alu-control)
   - [ALU](#alu)
   - [Muxes](#muxes)
   - [Data Memory](#data-memory)
   - [Branch Logic](#branch-logic)
6. [Testing and Simulation](#testing-and-simulation)
7. [Waveform Analysis](#waveform-analysis)
8. [Project Build Process](#project-build-process)
9. [Personal Reflection](#personal-reflection)
10. [Project Structure](#project-structure)
11. [References](#references)
12. [Future Work](#future-work)

## Project Overview

This project implements a **RISC-V Single-Cycle CPU** from scratch using Verilog. The processor supports basic arithmetic, logic, memory access, and branching instructions. The goal of this project is to simulate and analyze the behavior of a simple CPU core executing a short RISC-V instruction program.

## What is RISC-V and How It Compares to CISC

**RISC-V** is a free and open-source Instruction Set Architecture (ISA) based on the RISC (Reduced Instruction Set Computer) principles. In contrast, **CISC (Complex Instruction Set Computer)** architectures like x86 feature complex instructions that may take multiple cycles.

In this project, we chose RISC-V because it's the **modern industry standard** for instruction sets and well-suited for educational CPU designs like this one. The **single-cycle** approach emphasizes clarity while demonstrating core principles.

## Single Cycle vs Pipelined Architecture

| Feature            | Single-Cycle CPU     | Pipelined CPU          |
| ------------------ | -------------------- | ---------------------- |
| Clock Cycles/Instr | 1 (fixed)            | ~1 (on average)        |
| Performance        | Lower (longer cycle) | Higher (shorter cycle) |
| Design Complexity  | Simpler              | More complex           |

This CPU is implemented as a **single-cycle architecture** for clarity and simplicity.


## Features and Instruction Support

### Supported Instructions

- **R-type**: `add`, `sub`, `xor`, `slt`
- **I-type**: `addi`, `xori`, `slti`, `slli`, `ori`
- **S-type**: `sw`
- **L-type**: `lw`
- **B-type**: `beq`, `blt`
- **NOP**: encoded as `0x00000000`

### Not Yet Implemented

- `jal`, `jalr`, `auipc`, `lui`, other branch types

  ## Module Overview

### Program Counter (PC)
- Holds address of current instruction.
- Increments by 4 each cycle unless a branch is taken.

### PC Adder
- Computes `PC + 4` to advance instruction address.

### Instruction Memory
- Stores up to 64 instructions.
- Accessed using current PC value.

### Register File
- Contains 32 registers, each 32 bits.
- Supports simultaneous reading of two registers and writing to one.

📷 *Initial Register Contents:* `pictures/regs_before.png`  
📷 *Final Register Contents:* `pictures/regs_after.png`

### Immediate Generator
- Extracts and sign-extends immediates for different instruction formats.

📄 *Immediate Decoding Table*:

| Type | Bit Fields                     | Expression                 |
|------|--------------------------------|----------------------------|
| I    | `instr[31:20]`                 | Sign-extend to 32 bits     |
| S    | `instr[31:25]` + `instr[11:7]` | Sign-extend                |
| B    | `instr[31], 7, 30:25, 11:8, 0` | Sign-extend + shift-left-1 |

### Main Control Unit
- Decodes opcode to generate control signals: ALUOp, Branch, MemRead, etc.

### ALU Control
- Interprets `funct3`, `funct7`, and `ALUOp` to select operation.

📄 *ALU Operation Table*:

| ALUOp | Funct7  | Funct3 | Operation     |
|-------|---------|--------|---------------|
| 10    | 0000000 | 000    | ADD / ADDI    |
| 10    | 0100000 | 000    | SUB           |
| 10    | xxxxxxx | 010    | SLT / SLTI    |
| 10    | xxxxxxx | 111    | AND / ANDI    |
| 10    | xxxxxxx | 110    | OR / ORI      |
| 10    | xxxxxxx | 100    | XOR / XORI    |
| 10    | 0000000 | 001    | SLL / SLLI    |
| 10    | 0000000 | 101    | SRL / SRLI    |
| 10    | 0100000 | 101    | SRA / SRAI    |
| 11    | 0000000 | 000    | SUB (BEQ)     |
| 11    | 0000000 | 100    | SLT (BLT)     |

