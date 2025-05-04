
vlib work
vlog pipeline_regs.v
vlog core_modules.v
vlog RISCV_Top.v
vlog RISCV_ToP_Tb.v

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
add wave -color lightblue -unsigned /RISCV_ToP_Tb/UUT/pc_current
add wave -color lightblue -unsigned /RISCV_ToP_Tb/UUT/pc_next
add wave -color lightblue -unsigned /RISCV_ToP_Tb/UUT/pc_input

# ========================
# INSTRUCTION
# ========================
add wave -divider "INSTRUCTION"
add wave -color orange -hex /RISCV_ToP_Tb/UUT/instr

# ========================
# REGISTER FILE
# ========================
add wave -divider "REGISTER FILE"
add wave -color green -signed /RISCV_ToP_Tb/UUT/rs1_val
add wave -color green -signed /RISCV_ToP_Tb/UUT/rs2_val
add wave -color yellow -radix signed /RISCV_ToP_Tb/UUT/RF/Registers

# ========================
# DATA MEMORY
# ========================
add wave -divider "DATA MEMORY"
add wave -color gray -radix unsigned /RISCV_ToP_Tb/UUT/DMEM/D_Memory

# ========================
# PIPELINE REGISTERS
# ========================
add wave -divider "IF/ID"
add wave -color orange -unsigned /RISCV_ToP_Tb/UUT/IF_ID/pc_out
add wave -color orange -hex /RISCV_ToP_Tb/UUT/IF_ID/instruction_out

add wave -divider "ID/EX"
add wave -color lightgreen -unsigned /RISCV_ToP_Tb/UUT/ID_EX/pc_out
add wave -color lightgreen -signed /RISCV_ToP_Tb/UUT/ID_EX/rs1_val_out
add wave -color lightgreen -signed /RISCV_ToP_Tb/UUT/ID_EX/rs2_val_out
add wave -color lightgreen -signed /RISCV_ToP_Tb/UUT/ID_EX/imm_out
add wave -color lightgreen -unsigned /RISCV_ToP_Tb/UUT/ID_EX/rd_out

add wave -divider "EX/MEM"
add wave -color magenta -signed /RISCV_ToP_Tb/UUT/EX_MEM/alu_result_out
add wave -color magenta -signed /RISCV_ToP_Tb/UUT/EX_MEM/rs2_val_out
add wave -color magenta -unsigned /RISCV_ToP_Tb/UUT/EX_MEM/rd_out
add wave -color magenta -unsigned /RISCV_ToP_Tb/UUT/EX_MEM/branch_target_out

add wave -divider "MEM/WB"
add wave -color cyan -signed /RISCV_ToP_Tb/UUT/MEM_WB/alu_result_out
add wave -color cyan -signed /RISCV_ToP_Tb/UUT/MEM_WB/read_data_out
add wave -color cyan -unsigned /RISCV_ToP_Tb/UUT/MEM_WB/rd_out

# ========================
# RUN SIMULATION
# ========================
run 2000ns
