module top_cpu (
    input clk,
    input reset,
    output done
);

    wire [15:0] instr;
    wire [15:0] if_id_instr;
    wire [7:0] result, imm, rdata_ram;
    wire [2:0] rd, rs1, rs2;
    wire [7:0] val_rs1, val_rs2;
    wire [4:0] op;
    wire [7:0] pc;
    wire [4:0] op_ex;
    wire [7:0] val_rs1_ex, val_rs2_ex;
    wire signed [7:0] imm_ex;
    wire [2:0] rd_ex;
    wire imm_mode_ex;
    wire start_ex;

    wire start, ready, imm_mode, is_load, is_store, is_jmp, is_branch;
    wire we, we_rf, we_ram;
    wire [7:0] alu_b = imm_mode_ex ? imm_ex : val_rs2_ex;
    wire [7:0] mem_addr = val_rs1 + imm;

    // Fetch stage
    instruction_rom rom (.addr(pc), .instr(instr));

    // IF/ID pipeline register
    if_id if_id_stage (
        .clk(clk),
        .rst(reset),
        .pc_in(pc),
        .instruction_in(instr),
        .pc_out(), // לא נעשה שימוש ב-pc_out בשלב זה
        .instruction_out(if_id_instr)
    );

    controller ctrl (
    .clk(clk),
    .reset(reset),
    .instr(if_id_instr),
    .op(op),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .imm(imm),
    .imm_mode(imm_mode),
    .is_load(is_load),
    .is_store(is_store),
    .is_jmp(is_jmp),
    .is_branch(is_branch),
    .done(done),
    .pc(pc)
	);


    id_ex id_ex_stage (
        .clk(clk),
        .rst(reset),
        .op_in(op),
        .val_rs1_in(val_rs1),
        .val_rs2_in(val_rs2),
        .imm_in(imm),
        .rd_in(rd),
        .rs1_in(rs1),
        .rs2_in(rs2),
        .imm_mode_in(imm_mode),
        .start_in(start),
        .pc_in(pc),
        .we_ram_in(is_store),
        .we_rf_in(1'b1), // נשתמש ב־ready בשלב WB
        .op_out(op_ex),
        .val_rs1_out(val_rs1_ex),
        .val_rs2_out(val_rs2_ex),
        .imm_out(imm_ex),
        .rd_out(rd_ex),
        .rs1_out(), // לא נעשה בהם שימוש כרגע
        .rs2_out(),
        .imm_mode_out(imm_mode_ex),
        .start_out(start_ex),
        .pc_out(),
        .we_ram_out(),
        .we_rf_out()
    );

    alu_comb alu (
		.op(op_ex),
		.a(val_rs1_ex),
		.b(alu_b),
		.result(result)
	);


    // EX/MEM pipeline register
    wire [7:0] alu_result_ex_mem, val_rs2_ex_mem;
    wire [2:0] rd_ex_mem;
    wire [7:0] mem_addr_ex_mem;
    wire we_ram_ex_mem, we_rf_ex_mem;

    ex_mem ex_mem_stage (
        .clk(clk),
        .rst(reset),
        .alu_result_in(result),
        .val_rs2_in(val_rs2_ex),
        .rd_in(rd_ex),
        .mem_addr_in(val_rs1_ex + imm_ex),
        .we_ram_in(is_store),
        .we_rf_in(1'b1),
        .alu_result_out(alu_result_ex_mem),
        .val_rs2_out(val_rs2_ex_mem),
        .rd_out(rd_ex_mem),
        .mem_addr_out(mem_addr_ex_mem),
        .we_ram_out(we_ram_ex_mem),
        .we_rf_out(we_rf_ex_mem)
    );

    // MEM/WB pipeline register
    wire [7:0] result_mem_wb, rdata_mem_wb;
    wire [2:0] rd_mem_wb;
    wire we_rf_mem_wb;

    mem_wb mem_wb_stage (
        .clk(clk),
        .rst(reset),
        .mem_data_in(rdata_ram),
        .alu_result_in(alu_result_ex_mem),
        .rd_in(rd_ex_mem),
        .we_rf_in(we_rf_ex_mem),
        .mem_data_out(rdata_mem_wb),
        .alu_result_out(result_mem_wb),
        .rd_out(rd_mem_wb),
        .we_rf_out(we_rf_mem_wb)
    );

    assign we_rf = we_rf_mem_wb;
    assign we_ram = we_ram_ex_mem;

    wire [7:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
    register_file rf (
        .clk(clk), .we(we_rf),
        .rs1(rs1), .rs2(rs2), .rd(rd_mem_wb),
        .wdata(is_load ? rdata_mem_wb : result_mem_wb),
        .rdata1(val_rs1), .rdata2(val_rs2),
        .reg0(reg0), .reg1(reg1), .reg2(reg2),
        .reg3(reg3), .reg4(reg4), .reg5(reg5),
        .reg6(reg6), .reg7(reg7)
    );

    data_ram ram (
        .clk(clk),
        .we(we_ram),
        .addr(mem_addr_ex_mem),
        .wdata(val_rs2_ex_mem),
        .rdata(rdata_ram)
    );

endmodule
