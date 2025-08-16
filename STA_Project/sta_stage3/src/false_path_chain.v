// =====================================================
// false_path_chain.v — synthetic "slow" triple-multiply
// Behind a mux that is functionally tied to select the
// fast path. We keep slow nets with 'keep' to prevent
// pruning so they'll still appear in timing.
//
// NOTE: We will NOT mark it false-path yet; first we
// will see it in timing, then add the constraint.
// =====================================================
module false_path_chain (
    input  wire        clk,
    input  wire        reset_n,
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [15:0] c,
    input  wire        sel,     // tie to 1'b0 in top
    output reg  [31:0] y
);
    // "Fast" path: cheap and intentionally selected
    wire [31:0] fast = {16'd0, a};

    // "Slow" path: triple multiply, kept from pruning
    (* keep = "true" *) wire [31:0] slow1 /* synthesis keep */ = a * b;
    (* keep = "true" *) wire [31:0] slow2 /* synthesis keep */ = slow1 * c;
    (* keep = "true" *) wire [31:0] slow3 /* synthesis keep */ = slow2 * 32'd3;

    wire [31:0] mux_out = sel ? slow3 : fast;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            y <= 32'd0;
        else
            y <= mux_out;
    end
endmodule