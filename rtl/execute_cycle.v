module execute_cycle(
    input wire clk,
    input wire reset,
    input wire[1:0]forwardAE,
    input wire[1:0]forwardBE,
    input wire [31:0] rd1E,
    input wire [31:0] rd2E,
    input wire [31:0] immE,
    input wire [31:0] pcE,
    input wire [31:0] pc_plus4_E,
    input wire [31:0] resultW,
    input wire [4:0] rdE,
    input wire reg_writeE,
    input wire alu_srcE,
    input wire mem_writeE,
    input wire[1:0] result_srcE,
    input wire jumpE,
    input wire branchE,
    input wire [2:0] alu_controlE,
    output wire [31:0] alu_resultM,
    output wire [31:0] write_dataM,
    output wire [31:0] pc_targetE,
    output wire pc_srcE,
    output wire [31:0] pc_plus4_M,
    output wire [4:0] rdM,
    output wire reg_writeM,
    output wire mem_writeM,
    output wire [1:0] result_srcM
);

wire [31:0] src_AEw, src_BEw, alu_resultEw, write_dataEw;
wire zeroE;
reg[31:0] alu_resultEr, write_dataEr,pc_plus4_Er;
reg[4:0] rdEr;
reg reg_writeEr, mem_writeEr;
reg [1:0] result_srcEr;
adder pc_adder (
    .a(pcE),
    .b(immE),
    .y(pc_targetE)
);

mux3to1 src_A_mux (
    .sel(forwardAE),
    .a(rd1E),
    .b(resultW),
    .c(alu_resultM),
    .y(src_AEw)
);

mux3to1 src_B_mux (
    .sel(forwardBE),
    .a(rd2E),
    .b(resultW),
    .c(alu_resultM),
    .y(write_dataEw)
);

mux2to1 src_B_alu_mux (
    .sel(alu_srcE),
    .a(write_dataEw),
    .b(immE),
    .y(src_BEw)
);

alu alu_unit (
    .a(src_AEw),
    .b(src_BEw),
    .alu_control(alu_controlE),
    .result(alu_resultEw),
    .zero(zeroE)
);

always @(posedge clk) begin
    if (reset) begin
        alu_resultEr <= 32'b0;
        write_dataEr <= 32'b0;
        rdEr <= 5'b0;
        reg_writeEr <= 1'b0;
        mem_writeEr <= 1'b0;
        result_srcEr <= 2'b0;
        pc_plus4_Er <= 32'b0;
    end else begin
        alu_resultEr <= alu_resultEw;
        write_dataEr <= write_dataEw;
        rdEr <= rdE;
        reg_writeEr <= reg_writeE;
        mem_writeEr <= mem_writeE;
        result_srcEr <= result_srcE;
        pc_plus4_Er <= pc_plus4_E;
    end
end
assign alu_resultM = (reset==1'b1)? 32'b0 : alu_resultEr;
assign write_dataM = (reset==1'b1)? 32'b0 : write_dataEr;
assign rdM = (reset==1'b1)? 5'b0 : rdEr;
assign pc_plus4_M = (reset==1'b1)? 32'b0 : pc_plus4_Er;
assign reg_writeM = (reset==1'b1)? 1'b0 : reg_writeEr;
assign mem_writeM = (reset==1'b1)? 1'b0 : mem_writeEr;
assign result_srcM = (reset==1'b1)? 2'b0 : result_srcEr;
assign pc_srcE = (branchE & zeroE)| jumpE;



endmodule
