module mux2to1(
    input wire sel,
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] y
);
always @(*) begin
    if (sel)
        y = b;
    else
        y = a;
end
endmodule
