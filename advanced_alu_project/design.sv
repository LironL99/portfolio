// advanced_alu.sv
// Advanced ALU module with various operations
module advanced_alu (
    input  logic signed [3:0] a,      // 4-bit signed input
    input  logic signed [3:0] b,      // 4-bit signed input
    input  logic [2:0] opcode,        // 3-bit operation code
    output logic signed [7:0] result  // 8-bit signed output
);
    always_comb begin
        case (opcode)
            3'b000: result = a + b;         // Addition
            3'b001: result = a - b;         // Subtraction
            3'b010: result = a & b;         // Bitwise AND
            3'b011: result = a | b;         // Bitwise OR
            3'b100: result = a * b;         // Multiplication
            3'b101: result = a <<< 1;       // Left shift (arithmetic)
            3'b110: result = a >>> 1;       // Right shift (arithmetic)
            3'b111: result = a ^ b;         // Bitwise XOR
            default: result = 0;
        endcase
    end
endmodule
