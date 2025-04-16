module data_ram (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] wdata,
    output reg [7:0] rdata
);
    reg [7:0] mem [0:255];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= wdata;
        rdata <= mem[addr];
    end

    // Initialize memory to 0
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 0;
    end
endmodule
