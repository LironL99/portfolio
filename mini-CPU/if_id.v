// ----------------------------------------------------
// Module: if_id
// Description: Pipeline register between IF and ID stages
// ----------------------------------------------------
module if_id (
    input clk,
    input rst,
    input [7:0] pc_in,
    input [15:0] instruction_in,
    output reg [7:0] pc_out,
    output reg [15:0] instruction_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc_out <= 8'b0;
        instruction_out <= 16'b0;
    end else begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
    end
end

endmodule
