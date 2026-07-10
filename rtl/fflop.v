module fflop(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [31:0] d,
    output reg [31:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 32'b0;
    end else if (enable) begin
        q <= d;
    end
end

endmodule
