
vlib work
vlog pipeline_regs.v
vlog core_modules.v
vlog forwarding_unit.v
vlog hazard_detection_unit.v
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

# ========================
# INSTRUCTION FLOW
# ========================
add wave -divider "INSTRUCTION FLOW"
add wave -color orange -hex /RISCV_ToP_Tb/UUT/instr
add wave -color orange -hex /RISCV_ToP_Tb/UUT/IF_ID/instruction_out
add wave -color green  -hex /RISCV_ToP_Tb/UUT/ID_EX/rd_out
add wave -color green  -hex /RISCV_ToP_Tb/UUT/EX_MEM/rd_out

# ========================
# DATA HAZARDS & FORWARDING
# ========================
add wave -divider "DATA HAZARDS"
add wave -color cyan /RISCV_ToP_Tb/UUT/stall
add wave -color cyan /RISCV_ToP_Tb/UUT/forward_a
add wave -color cyan /RISCV_ToP_Tb/UUT/forward_b
add wave -color cyan /RISCV_ToP_Tb/UUT/alu_input_1
add wave -color cyan /RISCV_ToP_Tb/UUT/alu_input_2
add wave -color cyan /RISCV_ToP_Tb/UUT/alu_result

# ========================
# CONTROL HAZARDS & BRANCH
# ========================
add wave -divider "CONTROL HAZARDS"
add wave -color magenta /RISCV_ToP_Tb/UUT/branch_taken
add wave -color magenta /RISCV_ToP_Tb/UUT/branch_rs1_val
add wave -color magenta /RISCV_ToP_Tb/UUT/branch_rs2_val

# ========================
# REGISTER FILE CONTENT
# ========================
add wave -divider "REGISTER FILE"
add wave -color yellow -radix unsigned /RISCV_ToP_Tb/UUT/RF/Registers

# ========================
# RUN SIMULATION
# ========================
run 5000ps
