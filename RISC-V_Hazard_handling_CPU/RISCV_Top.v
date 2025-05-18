module RISCV_Top(input clk, rst);

//================== WIRES ==================
wire [31:0] pc_current, pc_next, pc_input, instr, imm;
wire [31:0] rs1_val, rs2_val, alu_in2, alu_result;
wire [31:0] branch_target, mem_read_data, wb_data;
wire [1:0] ALUOp;
wire [3:0] alu_ctrl;

// Forwarding ALU inputs
wire [31:0] alu_input_1, alu_input_2;

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

wire stall;
wire [1:0] forward_a, forward_b;
wire [31:0] branch_rs1_val, branch_rs2_val;



//================== FETCH ==================
program_counter PC(.clk(clk), .rst(rst), .enable(~stall), .pc_in(pc_input), .pc_out(pc_current));

pc_adder PC_ADD(.pc_in(pc_current), .pc_next(pc_next));

Instruction_Memory IMEM(.clk(clk), .rst(rst), .read_address(pc_current), .instruction_out(instr));

if_id IF_ID(.clk(clk), .rst(rst), .enable(~stall), .flush(branch_taken), .pc_in(pc_current), .instruction_in(instr), .pc_out(pc_ifid), .instruction_out(instr_ifid));

//================== DECODE ==================
Register_File RF(.clk(clk), .rst(rst), .RegWrite(RegWrite_memwb),
                 .Rs1(instr_ifid[19:15]), .Rs2(instr_ifid[24:20]), .Rd(rd_memwb),
                 .Write_data(wb_data), .read_data1(rs1_val), .read_data2(rs2_val));
				 
immediate_generator IMM_GEN(.instruction(instr_ifid), .imm_out(imm));

main_control_unit CTRL(.opcode(instr_ifid[6:0]), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
                       .MemToReg(MemToReg), .ALUSrc(ALUSrc), .Branch(Branch), .ALUOp(ALUOp));
					   
id_ex ID_EX(.clk(clk), .rst(rst), .flush(stall || branch_taken),
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

Mux1 ALU_SRC_MUX(
  .A1(rs2_val_idex),
  .B1(imm_idex),
  .select1(ALUSrc_idex),
  .Mux1_out(alu_in2)
);

ALU ALU(.A(alu_input_1), .B(alu_input_2), .ALUcontrol_In(alu_ctrl), .Result(alu_result), .Zero(zero));

Branch_Adder BRANCH_ADD(.PC(pc_ifid), .offset(imm), .branch_target(branch_target));

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


// ====================
// Forwarding Unit
// ====================

forwarding_unit FU (
    .id_ex_rs1(rs1_idex),
    .id_ex_rs2(rs2_idex),
    .ex_mem_rd(rd_exmem),
    .ex_mem_regwrite(RegWrite_exmem),
    .mem_wb_rd(rd_memwb),
    .mem_wb_regwrite(RegWrite_memwb),
    .forward_a(forward_a),
    .forward_b(forward_b)
);


assign alu_input_1 = (forward_a == 2'b00) ? rs1_val_idex :
                     (forward_a == 2'b10) ? alu_result_exmem :
                     (forward_a == 2'b01) ? wb_data :
                     32'bx;
					 
assign alu_input_2 = (ALUSrc_idex == 1'b1) ? alu_in2 :
                     (forward_b == 2'b00) ? rs2_val_idex :
                     (forward_b == 2'b10) ? alu_result_exmem :
                     (forward_b == 2'b01) ? wb_data :
                     32'bx;



// ====================
// Hazard Detection Unit
// ====================
hazard_detection_unit HDU (
    .id_ex_rd(rd_idex),
    .id_ex_memread(MemRead_idex),
    .if_id_rs1(instr_ifid[19:15]),
    .if_id_rs2(instr_ifid[24:20]),
    .stall_next(stall)
);


//================== NEXT PC ==================

assign branch_rs1_val =
    (RegWrite_idex && rd_idex != 0 && rd_idex == instr_ifid[19:15] && ALUSrc_idex) ? rs1_val_idex + imm_idex :
    (RegWrite_exmem && rd_exmem != 0 && rd_exmem == instr_ifid[19:15]) ? alu_result_exmem :
    (RegWrite_memwb && rd_memwb != 0 && rd_memwb == instr_ifid[19:15]) ? wb_data :
    rs1_val;

assign branch_rs2_val =
    (RegWrite_idex && rd_idex != 0 && rd_idex == instr_ifid[24:20] && ALUSrc_idex) ? rs1_val_idex + imm_idex :
    (RegWrite_exmem && rd_exmem != 0 && rd_exmem == instr_ifid[24:20]) ? alu_result_exmem :
    (RegWrite_memwb && rd_memwb != 0 && rd_memwb == instr_ifid[24:20]) ? wb_data :
    rs2_val;
	
assign branch_taken = Branch && (branch_rs1_val == branch_rs2_val);

Mux2 NEXT_PC_MUX(.A2(pc_next), .B2(branch_target), .select2(branch_taken), .Mux2_out(pc_input));

endmodule