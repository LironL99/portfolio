// top.v (Stage 1) — ensure a visible reg-to-reg path
module top (
    input  wire        clk,
    input  wire        reset_n,
    output wire [31:0] dout   // <-- expose the path to top-level
);
    // Keep these registers from being pruned.
    // Quartus honors both attribute and synthesis comment forms.
    (* preserve *) reg [31:0] r0 /* synthesis preserve */;
    (* preserve *) reg [31:0] r1 /* synthesis preserve */;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            r0 <= 32'd0;
            r1 <= 32'd0;
        end else begin
            r0 <= r0 + 32'd1; // activity source
            r1 <= r0;         // creates a reg-to-reg timing path
        end
    end

    assign dout = r1; // make the path observable
endmodule
