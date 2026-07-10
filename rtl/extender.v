module extender(
    input wire [31:7] instr,
    input wire [1:0] imm_type,
    output reg [31:0] imm
);

always @(*) begin
    case (imm_type)
        2'b00: imm = {{20{instr[31]}}, instr[31:20]}; // I-type
        2'b01: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
        2'b10: imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
        2'b11: imm = {instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type
        default: imm = 32'b0;
    endcase
end

endmodule
