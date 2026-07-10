module hazard_unit(
    input wire reset,
    input wire[4:0] rs1D,
    input wire[4:0] rs2D,
    input wire[4:0] rs1E,
    input wire[4:0] rs2E,
    input wire[4:0] rdE,
    input wire pc_srcE,
    input wire[1:0] result_srcE,
    input wire [4:0] rdM,
    input wire[4:0] rdW,
    input wire reg_writeM,
    input wire reg_writeW,
    output wire stalld,
    output wire stallf,
    output wire flushD,
    output wire flushE,
    output wire[1:0] forwardAE,
    output wire[1:0] forwardBE
);

wire lwstall;
assign forwardAE = (reset == 1'b1) ? 2'b00 :
                       ((reg_writeM == 1'b1) & (rs1E != 5'h00) & (rdM == rs1E)) ? 2'b10 :
                       ((reg_writeW == 1'b1) & (rs1E != 5'h00) & (rdW == rs1E)) ? 2'b01 : 2'b00;

assign forwardBE = (reset == 1'b1) ? 2'b00 :
                       ((reg_writeM == 1'b1) & (rs2E != 5'h00) & (rdM == rs2E)) ? 2'b10 :
                       ((reg_writeW == 1'b1) & (rs2E != 5'h00) & (rdW == rs2E)) ? 2'b01 : 2'b00;

assign lwstall =
        (result_srcE==2'b01) &&
        (rdE != 5'd0) &&
        ((rs1D == rdE) || (rs2D == rdE));

assign stallf = lwstall;

assign stalld = lwstall;

assign flushD = pc_srcE;

assign flushE = lwstall | pc_srcE;
endmodule
