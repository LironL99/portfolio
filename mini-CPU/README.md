# 🚀 RISC Pipeline CPU (Verilog)

A modular and extensible 5-stage pipelined RISC processor implemented in Verilog HDL.  
This project was built from scratch as part of a personal skill-building roadmap for RTL/Chip Design engineering roles.

---

## 🧠 Architecture Overview

The CPU follows a classic **5-stage pipeline**:

1. **IF** – Instruction Fetch from ROM  
2. **ID** – Instruction Decode and control signal generation  
3. **EX** – Execution via combinational ALU  
4. **MEM** – Load/store from/to data RAM  
5. **WB** – Register file writeback

Each pipeline stage is isolated by dedicated registers:
`if_id`, `id_ex`, `ex_mem`, `mem_wb`.

---

## 🔄 Evolution of the Project

This project was built iteratively with continuous refactoring and debugging:

### ✅ Initial Stage – Single-Cycle CPU
- Implemented a basic RISC processor with ALU, controller, register file, ROM/RAM
- Executed instructions sequentially, one per clock cycle
- Validated functional correctness via waveform simulation

### 🔧 Stage 2 – FSM-based ALU Integration
- Wrapped ALU logic inside a simple FSM to enable support for multi-cycle operations like `MUL` and `DIV`
- Introduced `start/ready` handshake between controller and ALU

### 🔁 Stage 3 – Full Pipeline Implementation
- Split architecture into 5 pipeline stages with dedicated registers:
  `if_id`, `id_ex`, `ex_mem`, `mem_wb`
- Refactored top-level wiring for modular stage transitions
- Removed FSM ALU in favor of purely **combinational** ALU (`alu_comb.v`) to support pipelining

### 🧼 Stage 4 – Controller Redesign
- Identified architectural mismatch: controller relied on register values in ID stage  
- Refactored to a **pure decode unit**, emitting only control signals and register indices  
- Moved `branch` decision logic out of controller (to be handled in EX stage)

### 🧪 Stage 5 – Debugging Pipeline Flow
- Added waveform hooks to track register file, ALU inputs, pipeline transitions
- Diagnosed `val_rs1/val_rs2` propagation issues due to timing and we_rf miswiring
- Refined simulation scripts (`simulate.do`) to inspect every stage

### 🛠️ Next Steps
- [ ] Implement forwarding logic (EX/MEM, MEM/WB)
- [ ] Add hazard detection unit and pipeline stalls
- [ ] Integrate branch resolution and flushing
- [ ] Expand test coverage for corner cases

---

## 🧪 Simulation Setup (ModelSim)

```tcl
do simulate.do
