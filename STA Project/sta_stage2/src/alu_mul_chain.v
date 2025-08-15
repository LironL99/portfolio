// =====================================================
// alu_mul_chain.v — "real" heavy path: two multiplies
// y = (a * b) * c, registered at the output.
// =====================================================
module alu_mul_chain (
    input  wire        clk,
    input  wire        reset_n,
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [15:0] c,
    output reg  [31:0] y
);
    wire [31:0] m1 = a * b;
    wire [31:0] m2 = m1 * c;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            y <= 32'd0;
        else
            y <= m2;
    end
endmodule