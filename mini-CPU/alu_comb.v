module alu_comb (
    input [4:0] op,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] result
);

always @(*) begin
    case (op)
        5'b00000: result = a + b;
        5'b00001: result = a - b;
        5'b00010: result = a & b;
        5'b00011: result = a | b;
        5'b00100: result = a ^ b;
        5'b00101: result = ~a;
        5'b00110: result = a % b;
        5'b00111: result = a * b;
        5'b01000: result = a / b;
        5'b01001: result = a << b;
        5'b01010: result = a >> b;
        default:  result = 8'b0;
    endcase
end

endmodule
