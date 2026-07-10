module memory_cycle(
    input wire clk,
    input wire reset,
    input wire reg_writeM,
    input wire mem_writeM,
    input wire [1:0] result_srcM,
    input wire[31:0] alu_resultM,
    input wire[31:0] write_dataM,
    input wire [31:0] pc_plus4_M,
    input wire [4:0] rdM,

    output wire reg_writeW,
    output wire[1:0] result_srcW,
    output wire[4:0] rdW,
    output wire[31:0]alu_resultW,
    output wire[31:0]read_dataW,
    output wire[31:0]pc_plus4_W


);

wire [31:0] read_dataMw;
reg[31:0] alu_resultMr,read_dataMr,pc_plus4_Mr;
reg[4:0]rdMr;
reg reg_writeMr;
reg[1:0] result_srcMr;

data_memory dmem (
                        .clk(clk),
                        .WE(mem_writeM),
                        .WD(write_dataM),
                        .A(alu_resultM),
                        .RD(read_dataMw)
                    );


always @(posedge clk) begin
    if (reset) begin
        alu_resultMr <= 32'b0;
        read_dataMr <= 32'b0;
        rdMr <= 5'b0;
        reg_writeMr <= 1'b0;
        result_srcMr <= 2'b0;
        pc_plus4_Mr <= 32'b0;
    end else begin
        alu_resultMr <= alu_resultM;
        read_dataMr <= read_dataMw;
        rdMr <= rdM;
        reg_writeMr <= reg_writeM;
        result_srcMr <= result_srcM;
        pc_plus4_Mr <= pc_plus4_M;
    end
end

assign reg_writeW = (reset==1'b1)? 1'b0:reg_writeMr;
assign result_srcW = (reset==1'b1)? 2'b0:result_srcMr;
assign rdW = (reset==1'b1)? 5'b0:rdMr;
assign alu_resultW = (reset==1'b1)? 32'b0:alu_resultMr;
assign read_dataW = (reset==1'b1)? 32'b0:read_dataMr;
assign pc_plus4_W  = (reset==1'b1)? 32'b0:pc_plus4_Mr;

endmodule

