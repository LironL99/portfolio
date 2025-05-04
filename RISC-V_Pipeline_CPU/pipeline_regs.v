//=========================== IF/ID Pipeline Register ===========================
module if_id (
    input clk,
    input rst,
    input [31:0] pc_in,
    input [31:0] instruction_in,

    output reg [31:0] pc_out,
    output reg [31:0] instruction_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc_out <= 0;
        instruction_out <= 0;
    end else begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
    end
end

endmodule


//=========================== ID/EX Pipeline Register ===========================
module id_ex (
    input clk,
    input rst,

    input [31:0] pc_in,
    input [31:0] rs1_val_in,
    input [31:0] rs2_val_in,
    input [31:0] imm_in,
    input [4:0] rd_in,
    input [2:0] funct3_in,
    input [6:0] funct7_in,
    input [4:0] rs1_in,
    input [4:0] rs2_in,

    input RegWrite_in,
    input MemRead_in,
    input MemWrite_in,
    input MemToReg_in,
    input ALUSrc_in,
    input Branch_in,
    input [1:0] ALUOp_in,

    output reg [31:0] pc_out,
    output reg [31:0] rs1_val_out,
    output reg [31:0] rs2_val_out,
    output reg [31:0] imm_out,
    output reg [4:0] rd_out,
    output reg [2:0] funct3_out,
    output reg [6:0] funct7_out,
    output reg [4:0] rs1_out,
    output reg [4:0] rs2_out,

    output reg RegWrite_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg ALUSrc_out,
    output reg Branch_out,
    output reg [1:0] ALUOp_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc_out <= 0;
        rs1_val_out <= 0;
        rs2_val_out <= 0;
        imm_out <= 0;
        rd_out <= 0;
        funct3_out <= 0;
        funct7_out <= 0;
        rs1_out <= 0;
        rs2_out <= 0;
        RegWrite_out <= 0;
        MemRead_out <= 0;
        MemWrite_out <= 0;
        MemToReg_out <= 0;
        ALUSrc_out <= 0;
        Branch_out <= 0;
        ALUOp_out <= 0;
    end else begin
        pc_out <= pc_in;
        rs1_val_out <= rs1_val_in;
        rs2_val_out <= rs2_val_in;
        imm_out <= imm_in;
        rd_out <= rd_in;
        funct3_out <= funct3_in;
        funct7_out <= funct7_in;
        rs1_out <= rs1_in;
        rs2_out <= rs2_in;
        RegWrite_out <= RegWrite_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        MemToReg_out <= MemToReg_in;
        ALUSrc_out <= ALUSrc_in;
        Branch_out <= Branch_in;
        ALUOp_out <= ALUOp_in;
    end
end

endmodule


//=========================== EX/MEM Pipeline Register ===========================
module ex_mem (
    input clk,
    input rst,

    input [31:0] alu_result_in,
    input [31:0] rs2_val_in,
    input [4:0] rd_in,
    input [31:0] branch_target_in,
    input zero_in,

    input MemRead_in,
    input MemWrite_in,
    input MemToReg_in,
    input RegWrite_in,
    input Branch_in,

    output reg [31:0] alu_result_out,
    output reg [31:0] rs2_val_out,
    output reg [4:0] rd_out,
    output reg [31:0] branch_target_out,
    output reg zero_out,

    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg RegWrite_out,
    output reg Branch_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        alu_result_out <= 0;
        rs2_val_out <= 0;
        rd_out <= 0;
        branch_target_out <= 0;
        zero_out <= 0;
        MemRead_out <= 0;
        MemWrite_out <= 0;
        MemToReg_out <= 0;
        RegWrite_out <= 0;
        Branch_out <= 0;
    end else begin
        alu_result_out <= alu_result_in;
        rs2_val_out <= rs2_val_in;
        rd_out <= rd_in;
        branch_target_out <= branch_target_in;
        zero_out <= zero_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
        Branch_out <= Branch_in;
    end
end

endmodule


//=========================== MEM/WB Pipeline Register ===========================
module mem_wb (
    input clk,
    input rst,

    // Inputs from MEM stage
    input [31:0] alu_result_in,
    input [31:0] read_data_in,
    input [4:0] rd_in,
    input MemToReg_in,
    input RegWrite_in,

    // Outputs to WB stage
    output reg [31:0] alu_result_out,
    output reg [31:0] read_data_out,
    output reg [4:0] rd_out,
    output reg MemToReg_out,
    output reg RegWrite_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        alu_result_out <= 0;
        read_data_out <= 0;
        rd_out <= 0;
        MemToReg_out <= 0;
        RegWrite_out <= 0;
    end else begin
        alu_result_out <= alu_result_in;
        read_data_out <= read_data_in;
        rd_out <= rd_in;
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
    end
end

endmodule
