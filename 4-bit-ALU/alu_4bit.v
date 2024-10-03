// Project Title: 4-bit ALU Implementation
// Author: Liron Leibovich
// Date: 03/10/2024
// Description: This module implements a 4-bit ALU that performs various arithmetic and logical operations, 
// including addition, subtraction, bitwise operations, and comparisons.

// Usage Instructions
// 1. Inputs:
//    - A: 4-bit input A (0 to 15).
//    - B: 4-bit input B (0 to 15).
//    - ctrl: 3-bit control signal that selects the operation.
//    - enable: 1-bit enable signal (1 to enable the ALU, 0 to disable).

// 2. Outputs:
//    - result: 4-bit output containing the result of the operation.
//    - zero: 1-bit output indicating if the result is zero.
//    - overflow: 1-bit output indicating if there was an overflow in arithmetic operations.

// Control Signal Table
// Control Signal (ctrl) | Operation         | Description
// -----------------------|-------------------|---------------------------------------------
// 3'b000                | Addition          | A + B
// 3'b001                | Subtraction       | A - B
// 3'b010                | AND               | A & B
// 3'b011                | OR                | A | B
// 3'b100                | XOR               | A ^ B
// 3'b101                | NAND              | ~(A & B)
// 3'b110                | NOR               | ~(A | B)
// 3'b111                | Bitwise NOT       | ~A
// 3'b1000               | Logical Shift Left| A << 1
// 3'b1001               | Logical Shift Right| A >> 1
// 3'b1010               | Arithmetic Shift Right | A >>> 1
// 3'b1011               | Less Than         | A < B (1 if true, 0 if false)
// 3'b1100               | Equal             | A == B (1 if true, 0 if false)
// 3'b1101               | Greater Than      | A > B (1 if true, 0 if false)
// 3'b1110               | Increment         | A + 1
// 3'b1111               | Decrement         | A - 1

// Example Outputs
// Here are some example outputs based on various test scenarios:
// 1. Addition Example:
//    - Input: A = `3` (0011), B = `2` (0010), ctrl = `000`
//    - Output: result = `5` (0101), zero = `0`, overflow = `0`
// 2. Subtraction Example:
//    - Input: A = `4` (0100), B = `2` (0010), ctrl = `001`
//    - Output: result = `2` (0010), zero = `0`, overflow = `0`
// 3. Overflow Example:
//    - Input: A = `7` (0111), B = `1` (0001), ctrl = `000`
//    - Output: result = `0` (0000), zero = `1`, overflow = `1`
// 4. Comparison Example:
//    - Input: A = `5` (0101), B = `3` (0011), ctrl = `110`
//    - Output: result = `0` (0000), zero = `0`, overflow = `0` (5 > 3)


module ALU (
    input [3:0] A,          // First operand
    input [3:0] B,          // Second operand
    input [2:0] ctrl,       // Control signals
    input enable,           // Enable signal
    output reg [3:0] result, // ALU result
    output reg zero,        // Zero flag
    output reg overflow      // Overflow flag
);

always @(*) begin
    if (enable) begin
        case (ctrl)
            3'b000: {overflow, result} = A + B; // Addition
            3'b001: {overflow, result} = A - B; // Subtraction
            3'b010: result = A & B; // AND
            3'b011: result = A | B; // OR
            3'b100: result = A ^ B; // XOR
            3'b101: result = ~(A & B); // NAND
            3'b110: result = ~(A | B); // NOR
            3'b111: result = ~A; // Bitwise NOT
            3'b1000: result = A << 1; // Logical Shift Left
            3'b1001: result = A >> 1; // Logical Shift Right
            3'b1010: result = A >>> 1; // Arithmetic Shift Right
            3'b1011: result = (A < B) ? 4'b0001 : 4'b0000; // Less Than
            3'b1100: result = (A == B) ? 4'b0001 : 4'b0000; // Equal
            3'b1101: result = (A > B) ? 4'b0001 : 4'b0000; // Greater Than
            3'b1110: result = A + 4'b0001; // Increment
            3'b1111: result = A - 4'b0001; // Decrement
            default: result = 4'b0000; // Default case
        endcase

        zero = (result == 4'b0000); // Set zero flag
    end else begin
        result = 4'b0000; // Clear result if not enabled
        zero = 1'b0;      // Clear zero flag
    end
end

endmodule
