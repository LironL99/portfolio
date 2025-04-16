module ex_mem (
    input clk,
    input rst,

    input [7:0] alu_result_in,
    input [7:0] val_rs2_in,
    input [2:0] rd_in,
    input [7:0] mem_addr_in,
    input we_ram_in,
    input we_rf_in,

    output reg [7:0] alu_result_out,
    output reg [7:0] val_rs2_out,
    output reg [2:0] rd_out,
    output reg [7:0] mem_addr_out,
    output reg we_ram_out,
    output reg we_rf_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        alu_result_out <= 8'b0;
        val_rs2_out    <= 8'b0;
        rd_out         <= 3'b0;
        mem_addr_out   <= 8'b0;
        we_ram_out     <= 1'b0;
        we_rf_out      <= 1'b0;
    end else begin
        alu_result_out <= alu_result_in;
        val_rs2_out    <= val_rs2_in;
        rd_out         <= rd_in;
        mem_addr_out   <= mem_addr_in;
        we_ram_out     <= we_ram_in;
        we_rf_out      <= we_rf_in;
    end
end

endmodule
