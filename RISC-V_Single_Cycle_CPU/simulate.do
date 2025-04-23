
vlib work
vlog Single_Cycle.v
vsim -novopt RISCV_ToP_Tb

# ========================
# CLOCK & RESET
# ========================
add wave -divider "CLOCK & RESET"
add wave -color white /RISCV_ToP_Tb/clk
add wave -color white /RISCV_ToP_Tb/rst

# ========================
# PROGRAM COUNTER
# ========================
add wave -divider "PROGRAM COUNTER"
add wave -color lightblue -unsigned /RISCV_ToP_Tb/UUT/pc_out_wire
add wave -color lightblue -unsigned /RISCV_ToP_Tb/UUT/pc_next_wire
add wave -color lightblue -unsigned /RISCV_ToP_Tb/UUT/pc_wire

# ========================
# INSTRUCTION FETCH
# ========================
add wave -divider "INSTRUCTION FETCH"
add wave -color orange -hex /RISCV_ToP_Tb/UUT/decode_wire

# ========================
# REGISTER FILE
# ========================
add wave -divider "REGISTER FILE"
add wave -color lightgreen -unsigned /RISCV_ToP_Tb/UUT/Reg_File/Rs1
add wave -color lightgreen -unsigned /RISCV_ToP_Tb/UUT/Reg_File/Rs2
add wave -color lightgreen -unsigned /RISCV_ToP_Tb/UUT/Reg_File/Rd
add wave -color green -signed /RISCV_ToP_Tb/UUT/read_data1
add wave -color green -signed /RISCV_ToP_Tb/UUT/regtomux
add wave -color green -signed /RISCV_ToP_Tb/UUT/WB_data_wire
add wave -color yellow -radix signed /RISCV_ToP_Tb/UUT/Reg_File/Registers

# ========================
# IMMEDIATE & CONTROL
# ========================
add wave -divider "IMMEDIATE & CONTROL"
add wave -color magenta -signed /RISCV_ToP_Tb/UUT/immgen_wire
add wave -color magenta -unsigned /RISCV_ToP_Tb/UUT/ALUOp_wire
add wave -color magenta -unsigned /RISCV_ToP_Tb/UUT/ALUcontrol_wire
add wave -color red /RISCV_ToP_Tb/UUT/RegWrite
add wave -color red /RISCV_ToP_Tb/UUT/MemRead
add wave -color red /RISCV_ToP_Tb/UUT/MemWrite
add wave -color red /RISCV_ToP_Tb/UUT/MemToReg
add wave -color red /RISCV_ToP_Tb/UUT/ALUSrc
add wave -color red /RISCV_ToP_Tb/UUT/Branch
add wave -color cyan /RISCV_ToP_Tb/UUT/sel2

# ========================
# ALU
# ========================
add wave -divider "ALU"
add wave -color cyan -unsigned /RISCV_ToP_Tb/UUT/muxtoAlu
add wave -color cyan -unsigned /RISCV_ToP_Tb/UUT/WB_wire
add wave -color cyan /RISCV_ToP_Tb/UUT/Zero

# ========================
# BRANCH
# ========================
add wave -divider "BRANCH"
add wave -color yellow -unsigned /RISCV_ToP_Tb/UUT/branch_target

# ========================
# DATA MEMORY
# ========================
add wave -divider "DATA MEMORY"
add wave -color lightgray -unsigned /RISCV_ToP_Tb/UUT/WB_wire       ;# Address
add wave -color lightgray -unsigned /RISCV_ToP_Tb/UUT/regtomux      ;# Write Data
add wave -color lightgray -unsigned /RISCV_ToP_Tb/UUT/read_data_wire;# Read Data
add wave -color lightgray -radix unsigned /RISCV_ToP_Tb/UUT/Data_Mem/D_Memory

# ========================
# EVENT MARKERS
# ========================
# when -label "Branch Taken" {/RISCV_ToP_Tb/UUT/sel2 == 1}

# ========================
# RUN SIMULATION
# ========================
run 8000ns
