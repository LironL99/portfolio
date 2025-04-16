module controller (
    input clk,
    input reset,
    input [15:0] instr,
    output reg [4:0] op,
    output reg [2:0] rd, rs1, rs2,
    output reg signed [7:0] imm,
    output reg imm_mode,
    output reg is_load, is_store, is_jmp, is_branch,
    output reg done,
    output reg [7:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            done <= 0;
            op <= 5'b0;
            rd <= 3'b0;
            rs1 <= 3'b0;
            rs2 <= 3'b0;
            imm <= 8'sb0;
            imm_mode <= 0;
            is_load <= 0;
            is_store <= 0;
            is_jmp <= 0;
            is_branch <= 0;
        end else begin
            // Decode fields
            op <= instr[15:11];
            is_load   <= 0;
            is_store  <= 0;
            is_jmp    <= 0;
            is_branch <= 0;
            imm_mode  <= 0;

            case (instr[15:11])
                // R-type
                5'b00000, 5'b00001, 5'b00010, 5'b00011,
                5'b00100, 5'b00101, 5'b00110, 5'b00111,
                5'b01000, 5'b01001, 5'b01010, 5'b01011: begin
                    rd <= instr[10:8];
                    rs1 <= instr[7:5];
                    rs2 <= instr[4:2];
                    imm_mode <= 0;
                end

                // I-type
                5'b10000, 5'b10001, 5'b10010, 5'b10011, 5'b10100: begin
                    rd <= instr[10:8];
                    rs1 <= instr[7:5];
                    imm <= {{3{instr[4]}}, instr[4:0]};
                    imm_mode <= 1;
                    is_load <= (instr[15:11] == 5'b10001);
                end

                // S-type
                5'b11000: begin
                    rs2 <= instr[10:8];
                    rs1 <= instr[7:5];
                    imm <= {{3{instr[4]}}, instr[4:0]};
                    imm_mode <= 1;
                    is_store <= 1;
                end

                // B-type
                5'b11001, 5'b11010, 5'b11011, 5'b11100: begin
                    rs1 <= instr[10:8];
                    rs2 <= instr[7:5];
                    imm <= {{3{instr[4]}}, instr[4:0]};
                    imm_mode <= 0;
                    is_branch <= 1;
                end

                // J-type
                5'b11110: begin
                    imm <= instr[7:0];
                    is_jmp <= 1;
                end

                default: ; // NOP
            endcase

            // PC advance (קבוע בשלב זה – נבצע branch resolution בשלבים הבאים)
            pc <= pc + 1;

            // Halt at end of program
            if (pc >= 8'hFF)
                done <= 1;
        end
    end

endmodule
