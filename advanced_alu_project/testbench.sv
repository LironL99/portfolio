// tb_advanced_alu.sv
// Advanced testbench with random tests, assertions, functional coverage, and edge tests

module tb_advanced_alu;
    // Declare variables: a and b are 4-bit signed, opcode is 3-bit
    logic signed [3:0] a, b;
    logic [2:0] opcode;
    logic signed [7:0] result;

    // Instantiate the advanced ALU module
    advanced_alu uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    // Define a covergroup for functional coverage of the opcode
    covergroup alu_cov;
        coverpoint opcode {
            bins add    = {3'b000};
            bins sub    = {3'b001};
            bins and_op = {3'b010};
            bins or_op  = {3'b011};
            bins mult   = {3'b100};
            bins shl    = {3'b101};
            bins shr    = {3'b110};
            bins xor_op = {3'b111};
        }
    endgroup

    alu_cov cov_inst = new();

    initial begin
        // --- Random Tests Block ---
        integer num_tests;
        integer i;
        reg [8*16-1:0] op_name;  // 16-character string for opcode name

        num_tests = 100;  // Number of random tests
        for (i = 0; i < num_tests; i = i + 1) begin
            // Generate random values in the range -8 to 7 for signed variables
            a = $urandom_range(-8, 7);
            b = $urandom_range(-8, 7);
            opcode = $urandom_range(0, 7);  // 3-bit opcode (0 to 7)
            #10;  // Wait for the result to update

            // Sample functional coverage
            cov_inst.sample();

            // Determine opcode name using the declared reg variable
            case (opcode)
                3'b000: op_name = "Addition";
                3'b001: op_name = "Subtraction";
                3'b010: op_name = "AND";
                3'b011: op_name = "OR";
                3'b100: op_name = "Multiplication";
                3'b101: op_name = "Left Shift";
                3'b110: op_name = "Right Shift";
                3'b111: op_name = "XOR";
                default: op_name = "Unknown";
            endcase

            // Display random test results including binary representation of a, b, and result
            $display("Random Test %0d: a=%0d (%04b), b=%0d (%04b), opcode=%0b (%s), result=%0d (%08b)", 
                     i, a, a, b, b, opcode, op_name, result, result);

            // Assertions to verify the correct result for each operation
            if (opcode == 3'b000)
                assert (result == a + b) else $error("Addition error: a=%0d, b=%0d", a, b);
            else if (opcode == 3'b001)
                assert (result == a - b) else $error("Subtraction error: a=%0d, b=%0d", a, b);
            else if (opcode == 3'b010)
                assert (result == (a & b)) else $error("AND error: a=%0d, b=%0d", a, b);
            else if (opcode == 3'b011)
                assert (result == (a | b)) else $error("OR error: a=%0d, b=%0d", a, b);
            else if (opcode == 3'b100)
                assert (result == a * b) else $error("Multiplication error: a=%0d, b=%0d", a, b);
            else if (opcode == 3'b101)
                assert (result == (a <<< 1)) else $error("Left Shift error: a=%0d", a);
            else if (opcode == 3'b110)
                assert (result == (a >>> 1)) else $error("Right Shift error: a=%0d", a);
            else if (opcode == 3'b111)
                assert (result == (a ^ b)) else $error("XOR error: a=%0d, b=%0d", a, b);
        end

        // --- Deterministic Edge Tests ---
        $display("---- Deterministic Edge Tests ----");
        
        // Edge Test for Addition: use maximum positive values: a = 7, b = 7
        a = 7; b = 7; opcode = 3'b000; #10;
        $display("Edge Test Addition: a=%0d (%04b), b=%0d (%04b), opcode=%0b (Addition), result=%0d (%08b)", 
                 a, a, b, b, opcode, result, result);
        
        // Edge Test for Subtraction: use extreme: a = -8, b = 7
        a = -8; b = 7; opcode = 3'b001; #10;
        $display("Edge Test Subtraction: a=%0d (%04b), b=%0d (%04b), opcode=%0b (Subtraction), result=%0d (%08b)", 
                 a, a, b, b, opcode, result, result);
        
        // Edge Test for AND: use a = -8, b = 7 (binary: a=1000, b=0111)
        a = -8; b = 7; opcode = 3'b010; #10;
        $display("Edge Test AND: a=%0d (%04b), b=%0d (%04b), opcode=%0b (AND), result=%0d (%08b)", 
                 a, a, b, b, opcode, result, result);
        
        // Edge Test for OR: use a = -8, b = 7 (expecting all ones)
        a = -8; b = 7; opcode = 3'b011; #10;
        $display("Edge Test OR: a=%0d (%04b), b=%0d (%04b), opcode=%0b (OR), result=%0d (%08b)", 
                 a, a, b, b, opcode, result, result);
        
        // Edge Test for Multiplication: use a = -8, b = -8
        a = -8; b = -8; opcode = 3'b100; #10;
        $display("Edge Test Multiplication: a=%0d (%04b), b=%0d (%04b), opcode=%0b (Multiplication), result=%0d (%08b)", 
                 a, a, b, b, opcode, result, result);
        
        // Edge Test for Left Shift: use a = 7 (largest positive value)
        a = 7; opcode = 3'b101; #10;
        $display("Edge Test Left Shift: a=%0d (%04b), opcode=%0b (Left Shift), result=%0d (%08b)", 
                 a, a, opcode, result, result);
        
        // Edge Test for Right Shift: use a = -1 (all ones) to verify arithmetic shift
        a = -1; opcode = 3'b110; #10;
        $display("Edge Test Right Shift: a=%0d (%04b), opcode=%0b (Right Shift), result=%0d (%08b)", 
                 a, a, opcode, result, result);
        
        // Edge Test for XOR: use a = 7, b = -8 (7: 0111, -8: 1000, XOR: 1111)
        a = 7; b = -8; opcode = 3'b111; #10;
        $display("Edge Test XOR: a=%0d (%04b), b=%0d (%04b), opcode=%0b (XOR), result=%0d (%08b)", 
                 a, a, b, b, opcode, result, result);

        $finish;
    end
endmodule
