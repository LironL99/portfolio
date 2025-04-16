module mem_wb (
    input clk,
    input rst,

    input [7:0] mem_data_in,
    input [7:0] alu_result_in,
    input [2:0] rd_in,
    input we_rf_in,

    output reg [7:0] mem_data_out,
    output reg [7:0] alu_result_out,
    output reg [2:0] rd_out,
    output reg we_rf_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        mem_data_out   <= 8'b0;
        alu_result_out <= 8'b0;
        rd_out         <= 3'b0;
        we_rf_out      <= 1'b0;
    end else begin
        mem_data_out   <= mem_data_in;
        alu_result_out <= alu_result_in;
        rd_out         <= rd_in;
        we_rf_out      <= we_rf_in;
    end
end

endmodule
