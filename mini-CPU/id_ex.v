module id_ex (
    input clk,
    input rst,

    input [4:0] op_in,
    input [7:0] val_rs1_in,
    input [7:0] val_rs2_in,
    input [7:0] imm_in,
    input [2:0] rd_in,
    input [2:0] rs1_in,
    input [2:0] rs2_in,
    input imm_mode_in,
    input start_in,
    input [7:0] pc_in,
    input we_ram_in,
    input we_rf_in,

    output reg [4:0] op_out,
    output reg [7:0] val_rs1_out,
    output reg [7:0] val_rs2_out,
    output reg signed [7:0] imm_out,
    output reg [2:0] rd_out,
    output reg [2:0] rs1_out,
    output reg [2:0] rs2_out,
    output reg imm_mode_out,
    output reg start_out,
    output reg [7:0] pc_out,
    output reg we_ram_out,
    output reg we_rf_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        op_out         <= 5'b0;
        val_rs1_out    <= 8'b0;
        val_rs2_out    <= 8'b0;
        imm_out        <= 8'sb0;
        rd_out         <= 3'b0;
        rs1_out        <= 3'b0;
        rs2_out        <= 3'b0;
        imm_mode_out   <= 1'b0;
        start_out      <= 1'b0;
        pc_out         <= 8'b0;
        we_ram_out     <= 1'b0;
        we_rf_out      <= 1'b0;
    end else begin
        op_out         <= op_in;
        val_rs1_out    <= val_rs1_in;
        val_rs2_out    <= val_rs2_in;
        imm_out        <= imm_in;
        rd_out         <= rd_in;
        rs1_out        <= rs1_in;
        rs2_out        <= rs2_in;
        imm_mode_out   <= imm_mode_in;
        start_out      <= start_in;
        pc_out         <= pc_in;
        we_ram_out     <= we_ram_in;
        we_rf_out      <= we_rf_in;
    end
end

endmodule
