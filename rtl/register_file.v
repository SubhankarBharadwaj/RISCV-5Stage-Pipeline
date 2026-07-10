module register_file(
    input wire clk,
    input wire reg_write,
    input wire [4:0] A1,
    input wire [4:0] A2,
    input wire [4:0] A3,
    input wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);

reg [31:0] registers [31:0];

always @(posedge clk) begin
    if (reg_write && A3 != 0) begin
        registers[A3] <= write_data;
    end
end




assign read_data1 = (A1 != 0) ? registers[A1] : 32'b0;
assign read_data2 = (A2 != 0) ? registers[A2] : 32'b0;

integer i;

initial begin
    for (i = 0; i < 32; i = i + 1)
        registers[i] = 32'b0;
end





endmodule
