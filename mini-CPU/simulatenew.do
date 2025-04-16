vlib work
vmap work work

vlog alu_comb.v
vlog controller.v
vlog data_ram.v
vlog instruction_rom.v
vlog register_file.v
vlog if_id.v
vlog id_ex.v
vlog ex_mem.v
vlog mem_wb.v
vlog top_cpu.v
vlog top_cpu_tb.v

vsim work.top_cpu_tb

# Global signals
add wave -divider "Global"
add wave -hex top_cpu_tb/clk
add wave -hex top_cpu_tb/reset
add wave -hex top_cpu_tb/done

# IF Stage
add wave -divider "IF Stage"
add wave -hex top_cpu_tb/dut/pc
add wave -hex top_cpu_tb/dut/instr

# IF/ID Stage
add wave -divider "IF/ID Stage"
add wave -hex top_cpu_tb/dut/if_id_stage/pc_out
add wave -hex top_cpu_tb/dut/if_id_stage/instruction_out

# ID Stage
add wave -divider "ID Stage"
add wave -hex top_cpu_tb/dut/ctrl/instr
add wave -hex top_cpu_tb/dut/ctrl/op
add wave -hex top_cpu_tb/dut/ctrl/rs1
add wave -hex top_cpu_tb/dut/ctrl/rs2
add wave -hex top_cpu_tb/dut/ctrl/rd
add wave -hex top_cpu_tb/dut/ctrl/imm
add wave -hex top_cpu_tb/dut/ctrl/imm_mode
add wave -hex top_cpu_tb/dut/ctrl/is_load
add wave -hex top_cpu_tb/dut/ctrl/is_store
add wave -hex top_cpu_tb/dut/ctrl/is_branch
add wave -hex top_cpu_tb/dut/ctrl/is_jmp

# ID/EX Stage
add wave -divider "ID/EX Stage"
add wave -hex top_cpu_tb/dut/id_ex_stage/pc_out
add wave -hex top_cpu_tb/dut/id_ex_stage/op_out
add wave -hex top_cpu_tb/dut/id_ex_stage/val_rs1_out
add wave -hex top_cpu_tb/dut/id_ex_stage/val_rs2_out
add wave -hex top_cpu_tb/dut/id_ex_stage/imm_out
add wave -hex top_cpu_tb/dut/id_ex_stage/rd_out

# EX Stage
add wave -divider "EX Stage"
add wave -hex top_cpu_tb/dut/alu_b
add wave -hex top_cpu_tb/dut/result

# EX/MEM Stage
add wave -divider "EX/MEM Stage"
add wave -hex top_cpu_tb/dut/ex_mem_stage/alu_result_out
add wave -hex top_cpu_tb/dut/ex_mem_stage/val_rs2_out
add wave -hex top_cpu_tb/dut/ex_mem_stage/mem_addr_out
add wave -hex top_cpu_tb/dut/ex_mem_stage/rd_out
add wave -hex top_cpu_tb/dut/ex_mem_stage/we_ram_out
add wave -hex top_cpu_tb/dut/ex_mem_stage/we_rf_out

# MEM Stage
add wave -divider "MEM Stage"
add wave -hex top_cpu_tb/dut/ram/rdata
add wave -hex top_cpu_tb/dut/ram/we
add wave -hex top_cpu_tb/dut/ram/addr
add wave -hex top_cpu_tb/dut/ram/wdata

# MEM/WB Stage
add wave -divider "MEM/WB Stage"
add wave -hex top_cpu_tb/dut/mem_wb_stage/mem_data_out
add wave -hex top_cpu_tb/dut/mem_wb_stage/alu_result_out
add wave -hex top_cpu_tb/dut/mem_wb_stage/rd_out
add wave -hex top_cpu_tb/dut/mem_wb_stage/we_rf_out

# WB Stage
add wave -divider "WB Stage"
add wave -hex top_cpu_tb/dut/rf/wdata
add wave -hex top_cpu_tb/dut/rf/rd
add wave -hex top_cpu_tb/dut/rf/rs1
add wave -hex top_cpu_tb/dut/rf/rs2
add wave -hex top_cpu_tb/dut/rf/reg0
add wave -hex top_cpu_tb/dut/rf/reg1
add wave -hex top_cpu_tb/dut/rf/reg2
add wave -hex top_cpu_tb/dut/rf/reg3
add wave -hex top_cpu_tb/dut/rf/reg4
add wave -hex top_cpu_tb/dut/rf/reg5
add wave -hex top_cpu_tb/dut/rf/reg6
add wave -hex top_cpu_tb/dut/rf/reg7

run 1000ns
