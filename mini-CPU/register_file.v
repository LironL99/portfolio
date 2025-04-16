module register_file (
    input clk,
    input we,
    input [2:0] rs1, rs2, rd,
    input [7:0] wdata,
    output [7:0] rdata1, rdata2,
	output [7:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7
);
    reg [7:0] regs[0:7];

    assign rdata1 = regs[rs1];
    assign rdata2 = regs[rs2];
	
	assign reg0 = regs[0];
    assign reg1 = regs[1];
    assign reg2 = regs[2];
    assign reg3 = regs[3];
    assign reg4 = regs[4];
    assign reg5 = regs[5];
	assign reg6 = regs[6];
    assign reg7 = regs[7];
	
    always @(posedge clk)
        if (we && rd != 0)
            regs[rd] <= wdata;
			
    integer i;
	initial begin
    for (i = 0; i < 8; i = i + 1)
        regs[i] = 0;
	end
endmodule
