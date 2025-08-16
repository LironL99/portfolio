// =====================================================
// alu_mul_chain.v — pipelined version (3-cycle latency)
// Goal: split two back-to-back multiplies across stages
// to reduce per-cycle combinational delay.
// Stages:
//   S1: m1_r <= a * b
//   S2: m2_r <= m1_r * c_r      (align c via c_r)
//   S3: y    <= m2_r            (final register)
// =====================================================
module alu_mul_chain (
    input  wire        clk,
    input  wire        reset_n,
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [15:0] c,
    output reg  [31:0] y
);
    // Stage registers
    reg [31:0] m1_r;
    reg [15:0] c_r;
    reg [31:0] m2_r;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            m1_r <= 32'd0;
            c_r  <= 16'd0;
            m2_r <= 32'd0;
            y    <= 32'd0;
        end else begin
            // S1: first multiply
            m1_r <= a * b;
            // Align 'c' so S2 uses time-aligned operands
            c_r  <= c;
            // S2: second multiply
            m2_r <= m1_r * c_r;
            // S3: final register to close timing comfortably
            y    <= m2_r;
        end
    end
endmodule
