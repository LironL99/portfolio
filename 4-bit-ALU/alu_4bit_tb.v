// Project Title: 4-bit ALU Testbench
// Author: Liron Leibovich
// Date: 03/10/2024
// Description: This testbench verifies the functionality of the 4-bit ALU by applying various test cases 
// including arithmetic and logical operations, as well as edge cases.

`timescale 1ns / 1ps
 
module ALU_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] ctrl;
    reg enable;

    // Outputs
    wire [3:0] result;
    wire zero;
    wire overflow;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .ctrl(ctrl),
        .enable(enable),
        .result(result),
        .zero(zero),
        .overflow(overflow)
    );

    initial begin
        // Initialize Inputs
        A = 4'b0000;
        B = 4'b0000;
        ctrl = 3'b000;
        enable = 1;

        // Wait for global reset to finish
        #100;

        // Original Test Cases
        // Test Addition
        A = 4'b0011; B = 4'b0010; ctrl = 3'b000; // 3 + 2
        #10;
        $display("Addition: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Test Subtraction
        A = 4'b0100; B = 4'b0010; ctrl = 3'b001; // 4 - 2
        #10;
        $display("Subtraction: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Test AND
        A = 4'b1100; B = 4'b1010; ctrl = 3'b010; // 12 & 10
        #10;
        $display("AND: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Test OR
        A = 4'b1100; B = 4'b1010; ctrl = 3'b011; // 12 | 10
        #10;
        $display("OR: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Test XOR
        A = 4'b1100; B = 4'b1010; ctrl = 3'b100; // 12 ^ 10
        #10;
        $display("XOR: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Test NOT
        A = 4'b1100; ctrl = 3'b101; // ~12
        #10;
        $display("NOT: A: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, ctrl, result, zero, overflow);

        // Test Less Than Comparison
        A = 4'b0101; B = 4'b1001; ctrl = 3'b110; // 5 < 9
        #10;
        $display("Less Than Comparison: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Test Greater Than Comparison
        A = 4'b1001; B = 4'b0101; ctrl = 3'b111; // 9 > 5
        #10;
        $display("Greater Than Comparison: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Additional Test Cases
        // Edge Case: All Zero Inputs
        A = 4'b0000; B = 4'b0000; ctrl = 3'b000; // 0 + 0
        #10;
        $display("All Zero Inputs: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Edge Case: Zero Inputs with Subtraction
        A = 4'b0000; B = 4'b0000; ctrl = 3'b001; // 0 - 0
        #10;
        $display("Zero Inputs Subtraction: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Edge Case: Maximum Minus Minimum
        A = 4'b1111; B = 4'b0000; ctrl = 3'b001; // 15 - 0
        #10;
        $display("Maximum Minus Minimum: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Edge Case: Shift Left on Max Value
        A = 4'b1111; ctrl = 3'b1000; // 15 << 1
        #10;
        $display("Shift Left Max Value: A: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, ctrl, result, zero, overflow);

        // Edge Case: Shift Right on Zero
        A = 4'b0000; ctrl = 3'b1001; // 0 >> 1
        #10;
        $display("Shift Right Zero Value: A: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, ctrl, result, zero, overflow);

        // Edge Case: Comparison of Equal Values
        A = 4'b1000; B = 4'b1000; ctrl = 3'b110; // 8 == 8
        #10;
        $display("Comparison of Equal Values: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Edge Case: Comparison of Maximum Values
        A = 4'b1111; B = 4'b1110; ctrl = 3'b110; // 15 > 14
        #10;
        $display("Comparison of Max Values: A: %b, B: %b, ctrl: %b, result: %b, zero: %b, overflow: %b", A, B, ctrl, result, zero, overflow);

        // Finish the simulation
        $finish;
    end
endmodule
