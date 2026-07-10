`timescale 1ns/1ps

module processor_tb;

reg clk;
reg reset;

processor DUT(
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #300;

    $finish;
end

initial begin
    $dumpfile("processor.vcd");
    $dumpvars(0, processor_tb);
end

endmodule
