`include "adder.v"
`include "fflop.v"
`include "mux2to1.v"
`include "mux3to1.v"

`include "instruction_memory.v"

`include "fetch_cycle.v"
`include "decode_cycle.v"
`include "execute_cycle.v"
`include "memory_cycle.v"
`include "wb_cycle.v"

`include "controller.v"
`include "register_file.v"
`include "extender.v"
`include "alu.v"
`include "data_memory.v"
`include "hazard_unit.v"
module processor(

    input wire clk,
    input wire reset
);

    wire pc_srcE, reg_writeW, reg_writeE, alu_srcE, mem_writeE,branchE, reg_writeM, mem_writeM,jumpE;
    wire[1:0] result_srcE,result_srcM,result_srcW;
    wire [2:0] alu_controlE;
    wire [4:0] rdE, rdM, rdW;
    wire [31:0] pc_targetE, instrD, pcD, pc_plus4_D, resultW, rd1E, rd2E, immE, pcE, pc_plus4_E, pc_plus4_M, write_dataM, alu_resultM;
    wire [31:0] pc_plus4_W, alu_resultW, read_dataW;
    wire [4:0] rs1E, rs2E,rs1D,rs2D;
    wire [1:0] forwardBE, forwardAE;
    wire stallf,stalld,flushE,flushD;


    fetch_cycle Fetch (
                        .clk(clk),
                        .reset(reset),
                        .pc_srcE(pc_srcE),
                        .pc_targetE(pc_targetE),
                        .instrD(instrD),
                        .pcD(pcD),
                        .pc_plus4_D(pc_plus4_D),
                        .stallf(stallf),
                        .stalld(stalld),
                        .flushD(flushD)

                    );

    
    decode_cycle Decode (
                        .clk(clk), 
                        .reset(reset), 
                        .instrD(instrD), 
                        .pcD(pcD), 
                        .pc_plus4_D(pc_plus4_D), 
                        .reg_writeW(reg_writeW), 
                        .rdW(rdW), 
                        .resultW(resultW), 
                        .reg_writeE(reg_writeE), 
                        .alu_srcE(alu_srcE), 
                        .mem_writeE(mem_writeE), 
                        .result_srcE(result_srcE),
                        .branchE(branchE),  
                        .jumpE(jumpE),
                        .alu_controlE(alu_controlE), 
                        .rd1E(rd1E), 
                        .rd2E(rd2E), 
                        .immE(immE), 
                        .rdE(rdE), 
                        .pcE(pcE), 
                        .pc_plus4_E(pc_plus4_E),
                        .rs1E(rs1E),
                        .rs2E(rs2E),
                        .flushE(flushE)
                    );

    
    execute_cycle Execute (
                        .clk(clk), 
                        .reset(reset), 
                        .reg_writeE(reg_writeE), 
                        .alu_srcE(alu_srcE), 
                        .mem_writeE(mem_writeE), 
                        .result_srcE(result_srcE), 
                        .branchE(branchE), 
                        .alu_controlE(alu_controlE), 
                        .rd1E(rd1E), 
                        .rd2E(rd2E), 
                        .jumpE(jumpE),
                        .immE(immE), 
                        .rdE(rdE), 
                        .pcE(pcE), 
                        .pc_plus4_E(pc_plus4_E), 
                        .pc_srcE(pc_srcE), 
                        .pc_targetE(pc_targetE), 
                        .reg_writeM(reg_writeM), 
                        .mem_writeM(mem_writeM), 
                        .result_srcM(result_srcM), 
                        .rdM(rdM), 
                        .pc_plus4_M(pc_plus4_M), 
                        .write_dataM(write_dataM), 
                        .alu_resultM(alu_resultM),
                        .resultW(resultW),
                        .forwardAE(forwardAE),
                        .forwardBE(forwardBE)
                    );
    
    
    memory_cycle Memory (
                        .clk(clk), 
                        .reset(reset), 
                        .reg_writeM(reg_writeM), 
                        .mem_writeM(mem_writeM), 
                        .result_srcM(result_srcM), 
                        .rdM(rdM), 
                        .pc_plus4_M(pc_plus4_M), 
                        .write_dataM(write_dataM), 
                        .alu_resultM(alu_resultM), 
                        .reg_writeW(reg_writeW), 
                        .result_srcW(result_srcW), 
                        .rdW(rdW), 
                        .pc_plus4_W(pc_plus4_W), 
                        .alu_resultW(alu_resultW), 
                        .read_dataW(read_dataW)
                    );

    
    wb_cycle WriteBack (
                        .clk(clk), 
                        .reset(reset), 
                        .result_srcW(result_srcW), 
                        .pc_plus4_W(pc_plus4_W), 
                        .alu_resultW(alu_resultW), 
                        .read_dataW(read_dataW), 
                        .resultW(resultW)
                    );

    
    hazard_unit hazard_block (
                        .reset(reset), 
                        .reg_writeM(reg_writeM), 
                        .reg_writeW(reg_writeW), 
                        .rs1E(rs1E), 
                        .rs2E(rs2E), 
                        .rs1D(rs1D),
                        .rs2D(rs2D),
                        .rdE(rdE),
                        .pc_srcE(pc_srcE),
                        .result_srcE(result_srcE),
                        .rdM(rdM),
                        .rdW(rdW),
                        .flushD(flushD),
                        .flushE(flushE),
                        .stalld(stalld),
                        .stallf(stallf),
                        .forwardAE(forwardAE),
                        .forwardBE(forwardBE)
                        );
endmodule
