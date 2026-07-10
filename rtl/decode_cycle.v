module decode_cycle(
    input wire clk,
    input wire reset,
    input wire [31:0] instrD,
    input wire [31:0] pc_plus4_D,
    input wire [31:0] pcD,
    input wire [4:0] rdW,
    input wire [31:0] resultW,
    input wire reg_writeW,
    input wire flushE,
    output wire [31:0] pc_plus4_E,
    output wire [31:0] pcE,
    output wire [31:0] rd1E,
    output wire [31:0] rd2E,
    output wire [4:0] rs1E,
    output wire [4:0] rs2E,
    output wire [31:0] immE,
    output wire [4:0] rdE,
    output wire [4:0] rs1D,
    output wire [4:0] rs2D,
    output wire [4:0] rdD,
    output wire reg_writeE,
    output wire alu_srcE,
    output wire mem_writeE,
    output wire[1:0] result_srcE,
    output wire jumpE,
    output wire branchE,
    output wire [2:0] alu_controlE
);

wire reg_writeDw,alu_srcDw,mem_writeDw,branchDw,jumpDw;
wire [1:0] imm_srcDw,result_srcDw;
wire [2:0] alu_controlDw;
wire [4:0] rs1Dw,rs2Dw, rdDw;
wire[31:0] rd1_Dw, rd2_Dw,imm_ext_Dw;

    // Declaration of Interim Register
reg reg_writeDr, alu_srcDr, mem_writeDr, branchDr, jumpDr;
reg [1:0] result_srcDr;
reg [2:0] alu_controlDr;
reg [4:0] rs1Dr, rs2Dr, rdDr;
reg [31:0]  rd1_Dr, rd2_Dr, imm_ext_Dr, pc_plus4_Dr, pcDr;

controller ctrl (
    .opcode(instrD[6:0]),
    .funct3(instrD[14:12]),
    .funct7(instrD[30]),
    .mem_write(mem_writeDw),
    .reg_write(reg_writeDw),
    .alu_src(alu_srcDw),
    .imm_src(imm_srcDw),
    .result_src(result_srcDw),
    .alu_control(alu_controlDw),
    .jump(jumpDw),
    .branch(branchDw)
);

register_file reg_file (
    .clk(clk),
    .reg_write(reg_writeW),
    .A1(instrD[19:15]),
    .A2(instrD[24:20]),
    .A3(rdW),
    .write_data(resultW),
    .read_data1(rd1_Dw),
    .read_data2(rd2_Dw)
);

extender ext (
    .imm_type(imm_srcDw),
    .instr(instrD[31:7]),
    .imm(imm_ext_Dw)
);

assign rs1Dw = instrD[19:15];
assign rs2Dw = instrD[24:20];
assign rdDw = instrD[11:7];


always @(posedge clk) begin
    if (reset||flushE) begin
        reg_writeDr <= 1'b0;
        alu_srcDr <= 1'b0;
        mem_writeDr <= 1'b0;
        result_srcDr <= 2'b0;
        branchDr <= 1'b0;
        jumpDr <= 1'b0;
        alu_controlDr <= 3'b0;
        rd1_Dr <= 32'b0;
        rd2_Dr <= 32'b0;
        rs1Dr <= 5'b0;
        rs2Dr <= 5'b0;
        rdDr <= 5'b0;
        imm_ext_Dr <= 32'b0;
        pc_plus4_Dr <= 32'b0;
        pcDr <= 32'b0;
    end else begin
        reg_writeDr <= reg_writeDw;
        alu_srcDr <= alu_srcDw;
        mem_writeDr <= mem_writeDw;
        result_srcDr <= result_srcDw;
        branchDr <= branchDw;
        jumpDr <= jumpDw;
        alu_controlDr <= alu_controlDw;
        rd1_Dr <= rd1_Dw;
        rd2_Dr <= rd2_Dw;
        rs1Dr <= rs1Dw;
        rs2Dr <= rs2Dw;
        rdDr <= rdDw;
        imm_ext_Dr <= imm_ext_Dw;
        pc_plus4_Dr <= pc_plus4_D;
        pcDr <= pcD;
    end
end

assign pc_plus4_E = (reset== 1'b1) ? 32'b0 : pc_plus4_Dr;
assign pcE = (reset== 1'b1) ? 32'b0 : pcDr;
assign rd1E = (reset== 1'b1) ? 32'b0 : rd1_Dr;
assign rd2E = (reset== 1'b1) ? 32'b0 : rd2_Dr;
assign rs1E = (reset== 1'b1) ? 5'b0 : rs1Dr;
assign rs1D = (reset== 1'b1) ? 5'b0 : rs1Dw;
assign rs2D = (reset== 1'b1) ? 5'b0 : rs2Dw;
assign rdD = (reset== 1'b1) ? 5'b0 : rdDw;
assign rs2E = (reset== 1'b1) ? 5'b0 : rs2Dr;
assign rdE = (reset== 1'b1) ? 5'b0 : rdDr;
assign immE = (reset== 1'b1) ? 32'b0 : imm_ext_Dr;
assign reg_writeE = (reset== 1'b1) ? 1'b0 : reg_writeDr;
assign alu_srcE = (reset== 1'b1) ? 1'b0 : alu_srcDr;
assign mem_writeE = (reset== 1'b1) ? 1'b0 : mem_writeDr;
assign result_srcE = (reset== 1'b1) ? 2'b0 : result_srcDr;
assign jumpE = (reset== 1'b1) ? 1'b0 : jumpDr;
assign branchE = (reset== 1'b1) ? 1'b0 : branchDr;
assign alu_controlE = (reset== 1'b1) ? 3'b0 : alu_controlDr;



endmodule
