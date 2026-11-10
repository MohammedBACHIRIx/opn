`timescale 1ns / 1ps

module tb_buck_converter();

    reg clk;
    reg rst;
    reg pwm;
    reg signed [63:0] v_in;
    wire signed [63:0] v_out;
    wire signed [63:0] i_L;

    buck_converter_hil uut (
        .clk(clk),
        .rst(rst),
        .pwm(pwm),
        .v_in(v_in),
        .v_out(v_out),
        .i_L(i_L)
    );

    // Clock generation: 1MHz
    initial begin
        clk = 0;
        forever #500 clk = ~clk;
    end

    // PWM generation: 50kHz, 50% duty cycle
    // Period = 20us -> 20 clock cycles
    integer cycle_count = 0;
    always @(posedge clk) begin
        if (rst) begin
            cycle_count <= 0;
            pwm <= 0;
        end else begin
            if (cycle_count < 9) begin
                pwm <= 1;
                cycle_count <= cycle_count + 1;
            end else if (cycle_count < 19) begin
                pwm <= 0;
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 0;
                pwm <= 1;
            end
        end
    end

    real v_out_real;
    always @(*) begin
        v_out_real = v_out / (4294967296.0);
    end

    initial begin
        $dumpfile("buck_converter.vcd");
        $dumpvars(0, tb_buck_converter);

        rst = 1;
        // The prompt asks for "simulated 10V input and 50% PWM duty cycle, verifying convergence to ~19.6V"
        v_in = 64'h0000000A_00000000; // 10.0 in Q32.32 format

        #2000 rst = 0;

        // Run for 20ms to let it converge
        #20000000;

        $display("Time: %0t ns, V_out: %f V", $time, v_out_real);

        // Assert convergence to ~19.6V
        if (v_out_real > 19.4 && v_out_real < 19.8) begin
            $display("SUCCESS: Converged to ~19.6V");
        end else begin
            $display("FAILURE: Did not converge to ~19.6V");
        end

        $finish;
    end

endmodule
