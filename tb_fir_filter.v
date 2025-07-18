`timescale 1ns / 1ps

module tb_fir_filter;

    reg clk = 0;
    reg reset;
    reg signed [7:0] x_in;
    wire signed [15:0] y_out;

    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    always #5 clk = ~clk;  // 10 ns clock

    initial begin
        $dumpfile("fir_filter.vcd");
        $dumpvars(0, tb_fir_filter);

        reset = 1;
        x_in = 0;
        #10;
        reset = 0;

        // Apply test samples
        x_in = 8'd10; #10;
        x_in = 8'd20; #10;
        x_in = 8'd30; #10;
        x_in = 8'd40; #10;
        x_in = 8'd0;  #50;

        $finish;
    end

endmodule
