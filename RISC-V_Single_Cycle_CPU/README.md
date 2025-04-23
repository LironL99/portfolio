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
13. [Author and Contact](#author-and-contact)



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

### ALU

- Performs all arithmetic and logic instructions.
- Provides Zero flag used in branch decisions.

### Muxes

- **Mux1**: Selects between register and immediate for ALU input B.
- **Mux2**: Selects between `PC+4` and branch target.
- **Mux3**: Chooses between ALU result and memory data for writeback.

📷 *Mux Path Illustration:* `pictures/mux_diagram.png`

### Data Memory

- 64-entry memory for load/store operations.
- Word-aligned, uses ALU result as address.

### Branch Logic

- Computes branch target as `PC + (imm << 2)`.
- Uses `Branch & Zero` to decide branch.


### Testing and Simulation

#### Instruction Program

```verilog
I_Mem[0]  = 32'b00000000000000000000000000000000;    // NOP

// ADD x5 = x1 + x2      → 10 + 20 = 30
I_Mem[4]  = 32'b0000000_00010_00001_000_00101_0110011;

// SUB x6 = x2 - x1      → 20 - 10 = 10
I_Mem[8]  = 32'b0100000_00001_00010_000_00110_0110011;

// XOR x7 = x1 ^ x3      → 10 ^ 5 = 15
I_Mem[12] = 32'b0000000_00011_00001_100_00111_0110011;

// SLT x8 = (x4 < x2)    → 7 < 20 = 1
I_Mem[16] = 32'b0000000_00010_00100_010_01000_0110011;

// ADDI x9 = x1 + 5      → 10 + 5 = 15
I_Mem[20] = 32'b000000000101_00001_000_01001_0010011;

// SLTI x10 = x3 < 6     → 5 < 6 = 1
I_Mem[24] = 32'b000000000110_00011_010_01010_0010011;

// SLLI x11 = x1 << 2    → 10 << 2 = 40
I_Mem[28] = 32'b0000000_00010_00001_001_01011_0010011;

// SW x5 to MEM[3 + 0]   → Store 30 at address 5
I_Mem[32] = 32'b0000000_00101_00011_010_00000_0100011;

// LW x12 from MEM[3 + 0] → Load 30
I_Mem[36] = 32'b000000000000_00011_010_01100_0000011;

// ORI x13 = x1 | 0xF     → 10 | 15 = 15
I_Mem[40] = 32'b000000001111_00001_110_01101_0010011;

// BEQ x5, x12, skip next → equal, so branch
I_Mem[44] = 32'b0000000_00101_01100_000_00010_1100111;

// ADD x14 = x2 + x2      → only runs if not branched
I_Mem[48] = 32'b0000000_00010_00010_000_01110_0110011;

// BLT x4, x2, skip next → 7 < 20 = true → branch
I_Mem[52] = 32'b0000000_00010_00100_100_00010_1100111;

// ADD x15 = x3 + x3      → skipped due to branch
I_Mem[56] = 32'b0000000_00011_00011_000_01111_0110011;

I_Mem[60]  = 32'b00000000000000000000000000000000;    // NOP
```

### Simulation Setup

- **Clock**: 100ns period  
- **Reset**: Asserted for first 50ns  
- **Run time**: 8000ns  
- **Simulation performed in**: ModelSim 10.5b  

### Expected Waveform Snippets

📷 `pictures/full_waveform.png`  
📷 `pictures/registers_before.png`  
📷 `pictures/registers_after.png`

## Project Build Process

1. **Theoretical Study**: Learned about RISC-V architecture and ISA design using the *Computer Organization and Design* textbook.
2. **Module Implementation**: Built all modules manually in Verilog based on dataflow diagrams.
3. **Integration**: Manually wired modules together in the `RISCV_Top` module.
4. **Instruction Testing**: Wrote a test program to verify arithmetic, logic, memory, and branch functionality.
5. **Waveform Analysis**: Used ModelSim to trace signal correctness with `simulate.do` and waveform display.

## Personal Reflection

I completed this project while enrolled in the course *"Central Processing Unit Architecture - Theory"* by Dr. Guy Tel-Zur, which teaches ISA design with MIPS for instructional clarity. I decided to go a step further and implement a RISC-V processor, as it's more relevant for industry.

Although real-world RISC-V CPUs are pipelined, this single-cycle model served as an excellent foundation. The main challenge was learning both theory and implementation simultaneously. Progress was slow initially but accelerated as confidence grew.

I coded each module from scratch, gradually using ChatGPT to assist with code generation and debugging. Catching and fixing errors strengthened my understanding. All integration and signal connections were done manually based on architecture diagrams.

Overall, this project was both educational and enjoyable, and I see it as a strong basis for more advanced future projects.

## Project Structure
```structure
RISC-V_Single_Cycle_CPU/
├── Single_Cycle.v         # Full CPU implementation
├── RISCV_ToP_Tb.v         # Testbench
├── simulate.do            # Simulation waveform script
├── waveform.vcd           # Generated waveform
├── docs/                  # Supporting images, tables
├── pictures/              # PNG snapshots of waveforms, registers
├── Computer_Organization_And_Design_RISC-V Edition_Morgan_Kaufmann.pdf
```

## References

- **Computer Organization And Design: RISC-V Edition** — Morgan Kaufmann. *(Included in repo)*
- **Central Processing Unit Architecture - Theory** — Dr. Guy Tel-Zur, Ben-Gurion University

## Future Work

- Support for additional instructions: `jal`, `jalr`, `lui`, `auipc`
- MIPS or RISC-V pipeline extension
- Hazard detection and forwarding
- Full assembler + memory file loader

## Author and Contact

This project was created and maintained by **Liron Leibovich**, a fourth-year Electrical and Computer Engineering student at Ben-Gurion University of the Negev.

For questions, feedback, or collaboration opportunities, feel free to connect:

- 📧 Email: lironleibovich@gmail.com  
- 🌐 LinkedIn: [linkedin.com/in/lironleibovich](https://www.linkedin.com/in/lironleibovich/)
- 💻 GitHub: [github.com/LironL99](https://github.com/LironL99)
