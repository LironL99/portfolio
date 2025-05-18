module forwarding_unit (
    input  [4:0] id_ex_rs1,
    input  [4:0] id_ex_rs2,
    input  [4:0] ex_mem_rd,
    input        ex_mem_regwrite,
    input  [4:0] mem_wb_rd,
    input        mem_wb_regwrite,
    output reg [1:0] forward_a,
    output reg [1:0] forward_b
);

    always @(*) begin
        // Default values: no forwarding
        forward_a = 2'b00;
        forward_b = 2'b00;

        // Check forwarding for rs1
        if (ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rs1))
            forward_a = 2'b10;
        else if (mem_wb_regwrite && (mem_wb_rd != 0) && (mem_wb_rd == id_ex_rs1))
            forward_a = 2'b01;

        // Check forwarding for rs2
        if (ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rs2))
            forward_b = 2'b10;
        else if (mem_wb_regwrite && (mem_wb_rd != 0) && (mem_wb_rd == id_ex_rs2))
            forward_b = 2'b01;
    end

endmodule
