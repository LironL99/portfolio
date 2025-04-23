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

