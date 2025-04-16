module instruction_rom (
    input [7:0] addr,
    output reg [15:0] instr
);

    always @(*) begin
        case (addr)
            8'd0: instr = 16'b10000_001_000_00001; // ADDI r1, r0, 1
            8'd1: instr = 16'b10000_010_000_00010; // ADDI r2, r0, 2
            8'd2: instr = 16'b00000_011_001_010_00; // ADD  r3, r1, r2
            8'd3: instr = 16'b00001_100_011_010_00; // SUB  r4, r3, r2
            8'd4: instr = 16'b00010_101_001_100_00; // AND  r5, r1, r4
            8'd5: instr = 16'b00011_110_101_010_00; // OR   r6, r5, r2
            8'd6: instr = 16'b00100_111_110_001_00; // XOR  r7, r6, r1
            8'd7: instr = 16'b11110_00000001_00;     // JMP 1
            default: instr = 16'b00000_000_000_00000;
        endcase
    end

endmodule
