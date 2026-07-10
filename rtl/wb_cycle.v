module wb_cycle(
    input wire clk,
    input wire reset,
    input wire[1:0] result_srcW,
    input wire[31:0]alu_resultW,
    input wire[31:0]read_dataW,
    input wire[31:0] pc_plus4_W,
    output wire[31:0]resultW
);

mux3to1 result_mux(
    .sel(result_srcW),
    .a(alu_resultW),
    .b(read_dataW),
    .c(pc_plus4_W),
    .y(resultW)
);

endmodule
