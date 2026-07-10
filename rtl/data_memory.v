module data_memory(
    input wire clk,
    input wire WE,
    input wire [31:0] A,
    input wire [31:0] WD,
    output wire [31:0] RD
);

reg [31:0] mem [1023:0];

integer i;

initial begin
    for(i = 0; i < 1024; i = i + 1)
        mem[i] = 32'd0;
end

always @(posedge clk) begin
    if(WE)
        mem[A[31:2]] <= WD;
end

assign RD = mem[A[31:2]];


endmodule
