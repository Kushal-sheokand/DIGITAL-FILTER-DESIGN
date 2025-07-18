module fir_filter #(parameter N = 4)(
    input clk,
    input reset,
    input signed [7:0] x_in,
    output reg signed [15:0] y_out
);

    // Filter Coefficients (example: low-pass FIR filter)
    reg signed [7:0] coeffs[0:N-1];
    initial begin
        coeffs[0] = 8'd2;
        coeffs[1] = 8'd4;
        coeffs[2] = 8'd4;
        coeffs[3] = 8'd2;
    end

    // Shift register for input samples
    reg signed [7:0] shift_reg[0:N-1];

    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < N; i = i + 1)
                shift_reg[i] <= 0;
            y_out <= 0;
        end else begin
            // Shift input samples
            for (i = N-1; i > 0; i = i - 1)
                shift_reg[i] <= shift_reg[i-1];
            shift_reg[0] <= x_in;

            // FIR calculation
            y_out <= 0;
            for (i = 0; i < N; i = i + 1)
                y_out <= y_out + shift_reg[i] * coeffs[i];
        end
    end

endmodule
