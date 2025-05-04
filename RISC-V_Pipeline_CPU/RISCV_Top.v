module RISCV_Top(input clk, rst);

//================== WIRES ==================
wire [31:0] pc_current, pc_next, pc_input, instr, imm;
wire [31:0] rs1_val, rs2_val, alu_in2, alu_result;
wire [31:0] branch_target, mem_read_data, wb_data;
wire [1:0] ALUOp;
wire [3:0] alu_ctrl;


// IF/ID
wire [31:0] pc_ifid, instr_ifid;

// ID/EX
wire [31:0] pc_idex, imm_idex, rs1_val_idex, rs2_val_idex;
wire [4:0] rd_idex, rs1_idex, rs2_idex;
wire [2:0] funct3_idex;
wire [6:0] funct7_idex;
wire RegWrite_idex, MemRead_idex, MemWrite_idex, MemToReg_idex, ALUSrc_idex, Branch_idex;
wire [1:0] ALUOp_idex;

// EX/MEM
wire [31:0] alu_result_exmem, rs2_val_exmem, branch_target_exmem;
wire [4:0] rd_exmem;
wire zero_exmem;
wire RegWrite_exmem, MemRead_exmem, MemWrite_exmem, MemToReg_exmem, Branch_exmem;

// MEM/WB
wire [31:0] alu_result_memwb, mem_read_data_memwb;
wire [4:0] rd_memwb;
wire RegWrite_memwb, MemToReg_memwb;

//================== FETCH ==================
program_counter PC(.clk(clk), .rst(rst), .pc_in(pc_input), .pc_out(pc_current));

pc_adder PC_ADD(.pc_in(pc_current), .pc_next(pc_next));

Instruction_Memory IMEM(.clk(clk), .rst(rst), .read_address(pc_current), .instruction_out(instr));

if_id IF_ID(.clk(clk), .rst(rst), .pc_in(pc_current), .instruction_in(instr), .pc_out(pc_ifid), .instruction_out(instr_ifid));

//================== DECODE ==================
Register_File RF(.clk(clk), .rst(rst), .RegWrite(RegWrite_memwb),
                 .Rs1(instr_ifid[19:15]), .Rs2(instr_ifid[24:20]), .Rd(rd_memwb),
                 .Write_data(wb_data), .read_data1(rs1_val), .read_data2(rs2_val));
				 
immediate_generator IMM_GEN(.instruction(instr_ifid), .imm_out(imm));

main_control_unit CTRL(.opcode(instr_ifid[6:0]), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
                       .MemToReg(MemToReg), .ALUSrc(ALUSrc), .Branch(Branch), .ALUOp(ALUOp));
					   
id_ex ID_EX(.clk(clk), .rst(rst),
            .pc_in(pc_ifid), .rs1_val_in(rs1_val), .rs2_val_in(rs2_val), .imm_in(imm),
            .rd_in(instr_ifid[11:7]), .funct3_in(instr_ifid[14:12]), .funct7_in(instr_ifid[31:25]),
            .rs1_in(instr_ifid[19:15]), .rs2_in(instr_ifid[24:20]),
            .RegWrite_in(RegWrite), .MemRead_in(MemRead), .MemWrite_in(MemWrite),
            .MemToReg_in(MemToReg), .ALUSrc_in(ALUSrc), .Branch_in(Branch), .ALUOp_in(ALUOp),
            .pc_out(pc_idex), .rs1_val_out(rs1_val_idex), .rs2_val_out(rs2_val_idex),
            .imm_out(imm_idex), .rd_out(rd_idex), .funct3_out(funct3_idex), .funct7_out(funct7_idex),
            .rs1_out(rs1_idex), .rs2_out(rs2_idex),
            .RegWrite_out(RegWrite_idex), .MemRead_out(MemRead_idex), .MemWrite_out(MemWrite_idex),
            .MemToReg_out(MemToReg_idex), .ALUSrc_out(ALUSrc_idex), .Branch_out(Branch_idex), .ALUOp_out(ALUOp_idex));

//================== EXECUTE ==================
ALU_Control ALU_CTRL(.funct3(funct3_idex), .funct7(funct7_idex), .ALUOp(ALUOp_idex), .ALUcontrol_Out(alu_ctrl));

Mux1 ALU_SRC_MUX(.A1(rs2_val_idex), .B1(imm_idex), .select1(ALUSrc_idex), .Mux1_out(alu_in2));

ALU ALU(.A(rs1_val_idex), .B(alu_in2), .ALUcontrol_In(alu_ctrl), .Result(alu_result), .Zero(zero));

Branch_Adder BRANCH_ADD(.PC(pc_idex), .offset(imm_idex), .branch_target(branch_target));

ex_mem EX_MEM(.clk(clk), .rst(rst),
              .alu_result_in(alu_result), .rs2_val_in(rs2_val_idex), .rd_in(rd_idex),
              .branch_target_in(branch_target), .zero_in(zero),
              .MemRead_in(MemRead_idex), .MemWrite_in(MemWrite_idex),
              .MemToReg_in(MemToReg_idex), .RegWrite_in(RegWrite_idex), .Branch_in(Branch_idex),
              .alu_result_out(alu_result_exmem), .rs2_val_out(rs2_val_exmem), .rd_out(rd_exmem),
              .branch_target_out(branch_target_exmem), .zero_out(zero_exmem),
              .MemRead_out(MemRead_exmem), .MemWrite_out(MemWrite_exmem),
              .MemToReg_out(MemToReg_exmem), .RegWrite_out(RegWrite_exmem), .Branch_out(Branch_exmem));

//================== MEMORY ==================
Data_Memory DMEM(.clk(clk), .rst(rst), .MemRead(MemRead_exmem), .MemWrite(MemWrite_exmem),
                 .address(alu_result_exmem), .write_data(rs2_val_exmem), .read_data(mem_read_data));
				 
mem_wb MEM_WB(.clk(clk), .rst(rst),
              .alu_result_in(alu_result_exmem), .read_data_in(mem_read_data),
              .rd_in(rd_exmem), .RegWrite_in(RegWrite_exmem), .MemToReg_in(MemToReg_exmem),
              .alu_result_out(alu_result_memwb), .read_data_out(mem_read_data_memwb),
              .rd_out(rd_memwb), .RegWrite_out(RegWrite_memwb), .MemToReg_out(MemToReg_memwb));

//================== WRITE BACK ==================
Mux3 WB_MUX(.A3(alu_result_memwb), .B3(mem_read_data_memwb), .select3(MemToReg_memwb), .Mux3_out(wb_data));

//================== NEXT PC ==================
AND_logic BRANCH_TAKEN(.branch(Branch_exmem), .zero(zero_exmem), .ALUOp(ALUOp_idex), .and_out(branch_taken));

Mux2 NEXT_PC_MUX(.A2(pc_next), .B2(branch_target_exmem), .select2(branch_taken), .Mux2_out(pc_input));

endmodule
