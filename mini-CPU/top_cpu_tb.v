`timescale 1ns/1ps

module top_cpu_tb;
    reg clk = 0, reset = 1;
    wire done;

    top_cpu dut (.clk(clk), .reset(reset), .done(done));
    always #5 clk = ~clk;

    initial begin
        #15 reset = 0;
        wait(done);
        #10;
        $finish;
    end
endmodule
