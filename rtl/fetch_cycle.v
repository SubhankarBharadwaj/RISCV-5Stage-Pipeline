
module fetch_cycle(
    input wire clk,
    input wire reset,
    input wire pc_srcE,
    input wire [31:0] pc_targetE,
    output wire [31:0] pcD,
    output wire [31:0] instrD,
    output wire [31:0] pc_plus4_D,
    input wire stallf,
    input wire stalld,
    input wire flushD
);

wire [31:0] pc_old,pc_next,pc_plus4,instr;
reg [31:0]instrF_r,pcF_r,pc_plus4_F_r;

mux2to1 pc_mux (
    .sel(pc_srcE),
    .a(pc_plus4),
    .b(pc_targetE),
    .y(pc_old)
);

fflop pc_reg (
    .clk(clk),
    .reset(reset),
    .enable(!stallf),
    .d(pc_old),
    .q(pc_next)
);

adder pc_add4(
    .a(pc_next),
    .b(32'd4),
    .y(pc_plus4)
);

instruction_memory imem (
    .reset(reset),
    .address(pc_next),
    .instr(instr)
);

always @(posedge clk) begin
    if (reset || flushD) begin
        pcF_r <= 32'b0;
        instrF_r <= 32'b0;
        pc_plus4_F_r <= 32'b0;
    end else if (!stalld) begin
        pcF_r <= pc_next;
        instrF_r <= instr;
        pc_plus4_F_r <= pc_plus4;
    end
end

assign pcD = (reset== 1'b1) ? 32'b0 : pcF_r;
assign instrD = (reset== 1'b1) ? 32'b0 : instrF_r;
assign pc_plus4_D = (reset== 1'b1) ? 32'b0 : pc_plus4_F_r;


endmodule
