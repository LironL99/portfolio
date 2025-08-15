// =====================================================
// top.v — Stage 2 integration (updated to make fake path WNS)
// * Drives changing operands so multiplies cannot fold.
// * Instantiates the real heavy path and the synthetic slow chain.
// * MUX select is now a live register (not a constant), so both
//   MUX arcs are analyzed by STA and the slow chain can become WNS.
// * Exposes dout to keep timing visible end-to-end.
// =====================================================
module top (
    input  wire        clk,
    input  wire        reset_n,
    output wire [31:0] dout
);
    // Simple operand generators (activity sources)
    // Use small counters to avoid constant folding.
    reg [15:0] cnt_a;
    reg [15:0] cnt_b;
    reg [15:0] cnt_c;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            cnt_a <= 16'd1;
            cnt_b <= 16'd3;
            cnt_c <= 16'd5;
        end else begin
            cnt_a <= cnt_a + 16'd1;
            cnt_b <= cnt_b + 16'd2;
            cnt_c <= cnt_c + 16'd3;
        end
    end

    // ----------------------------------------------------------------
    // NEW: live MUX select (no constant propagation by synthesis).
    // Option A: a dedicated FF that toggles:
    reg dbg_sel;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            dbg_sel <= 1'b0;
        else
            dbg_sel <= ~dbg_sel; // toggles every cycle; both mux arcs exist
    end
    // (Alternative: use a registered counter bit, e.g. wire dbg_sel = cnt_a[0];)
    // ----------------------------------------------------------------

    // Real heavy path: two multiplies
    wire [31:0] y_real;
    alu_mul_chain u_real (
        .clk    (clk),
        .reset_n(reset_n),
        .a      (cnt_a),
        .b      (cnt_b),
        .c      (cnt_c),
        .y      (y_real)
    );

    // Synthetic slow chain, now with LIVE select
    wire [31:0] y_slow;
    false_path_chain u_slow (
        .clk    (clk),
        .reset_n(reset_n),
        .a      (cnt_a),
        .b      (cnt_b),
        .c      (cnt_c),
        .sel    (dbg_sel),   // << was 1'b0; now a live register
        .y      (y_slow)
    );

    // Combine results so both subpaths are live in netlist
    (* preserve *) reg [31:0] r_out /* synthesis preserve */;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            r_out <= 32'd0;
        else
            // Mix y_slow lightly so the nets are used,
            // but keep y_real as the primary path of interest.
            r_out <= y_real ^ (y_slow >> 1);
    end

    assign dout = r_out;
endmodule
