
module hazard_detection_unit (
    input  [4:0] id_ex_rd,
    input        id_ex_memread,
    input  [4:0] if_id_rs1,
    input  [4:0] if_id_rs2,
    output       stall_next
);

    assign stall_next = id_ex_memread &&
                        ((id_ex_rd != 0) && ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2)));

endmodule
