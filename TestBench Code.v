module traffic_light_tb;

    reg clk;
    reg reset;

    wire A_red, A_yellow, A_green;
    wire B_red, B_yellow, B_green;

    // Instantiate DUT
    traffic_light DUT (
        .clk(clk),
        .reset(reset),
        .A_red(A_red),
        .A_yellow(A_yellow),
        .A_green(A_green),
        .B_red(B_red),
        .B_yellow(B_yellow),
        .B_green(B_green)
    );

    // Clock generation (10 time unit period)
    always #5 clk = ~clk;

    initial begin
        // Enable waveform dump
        $dumpfile("dump.vcd");
        $dumpvars(0, traffic_light_tb);

        clk = 0;
        reset = 1;

        #10 reset = 0;     // release reset
        #300 $finish;     // end simulation
    end

endmodule
