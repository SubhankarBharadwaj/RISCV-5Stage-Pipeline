module instruction_memory(
    input wire reset,
    input wire[31:0] address,
    output wire[31:0] instr
);

reg[31:0] mem[1023:0];

assign instr = (reset==1'b1)? 32'b0 : mem[address[31:2]];

initial begin
    $readmemh("memfile.hex",mem);
  end

endmodule
