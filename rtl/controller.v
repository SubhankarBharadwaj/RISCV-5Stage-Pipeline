`include "main_decoder.v"
`include "alu_decoder.v"

module controller(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire funct7,
    output wire mem_write,
    output wire reg_write,
    output wire alu_src,
    output wire[1:0] imm_src,
    output wire [1:0] result_src,
    output wire [2:0] alu_control,
    output wire jump,
    output wire branch
);
wire [1:0] alu_op;

main_decoder main_dec (
    .opcode(opcode),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .imm_src(imm_src),
    .result_src(result_src),
    .alu_op(alu_op),
    .branch(branch),
    .jump(jump),
    .alu_src(alu_src)
);

alu_decoder alu_dec (
    .alu_op(alu_op),
    .funct3(funct3),
    .funct7(funct7),
    .op5(opcode[5]),
    .alu_control(alu_control)
);


endmodule

