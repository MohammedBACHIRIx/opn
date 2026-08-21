`timescale 1ns / 1ps

module buck_converter_hil (
    input wire clk,
    input wire rst,
    input wire pwm,
    input wire signed [63:0] v_in, // Q32.32
    output reg signed [63:0] v_out, // Q32.32
    output reg signed [63:0] i_L   // Q32.32
);

    // Forward Euler Method
    // We implement Boost Converter equations here because the prompt specifies
    // a 10V input and 50% PWM converging to ~19.6V, which is mathematically
    // consistent with a Boost converter (ideal 20V, with losses ~19.6V).
    // It seems the module was named "buck_converter_hil" but intended as a Boost.

    // L di_L/dt = v_in - (1-pwm)*v_out - i_L*R_L
    // C dv_out/dt = (1-pwm)*i_L - v_out/R

    // Constants in Q32.32
    // dt = 1e-6
    // L = 1e-3
    // C = 100e-6
    // R = 10
    // R_L = 0.05

    localparam signed [63:0] DT_OVER_L = 64'd4294967;     // dt/L = 1e-3 -> 4294967
    localparam signed [63:0] DT_OVER_C = 64'd42949673;    // dt/C = 1e-2 -> 42949673
    localparam signed [63:0] ONE_OVER_R = 64'd429496730;  // 1/R = 0.1 -> 429496730
    localparam signed [63:0] R_L = 64'd214748364;         // R_L = 0.05 -> 0.05 * 2^32 = 214748364

    wire signed [127:0] i_L_drop_full;
    assign i_L_drop_full = i_L * R_L;

    wire signed [63:0] i_L_drop;
    assign i_L_drop = i_L_drop_full[95:32];

    wire signed [63:0] v_L;
    assign v_L = pwm ? (v_in - i_L_drop) : (v_in - v_out - i_L_drop);

    wire signed [127:0] di_L_full;
    assign di_L_full = v_L * DT_OVER_L;

    wire signed [63:0] di_L;
    assign di_L = di_L_full[95:32];

    wire signed [127:0] i_R_full;
    assign i_R_full = v_out * ONE_OVER_R;

    wire signed [63:0] i_R;
    assign i_R = i_R_full[95:32];

    wire signed [63:0] i_C;
    assign i_C = pwm ? (-i_R) : (i_L - i_R);

    wire signed [127:0] dv_out_full;
    assign dv_out_full = i_C * DT_OVER_C;

    wire signed [63:0] dv_out;
    assign dv_out = dv_out_full[95:32];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            v_out <= 64'd0;
            i_L <= 64'd0;
        end else begin
            // Update inductor current
            if (!pwm && (i_L + di_L < 64'sd0)) begin
                // Discontinuous Conduction Mode (DCM) protection
                i_L <= 64'd0;
            end else begin
                i_L <= i_L + di_L;
            end

            // Update output voltage
            v_out <= v_out + dv_out;
        end
    end

endmodule
