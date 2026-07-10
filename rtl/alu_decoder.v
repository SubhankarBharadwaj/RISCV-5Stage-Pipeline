module alu_decoder(
    input wire [1:0] alu_op,
    input wire [2:0] funct3,
    input wire funct7,
    input wire op5,
    output reg[2:0] alu_control
);
wire r_type;
assign r_type = funct7 & op5;
always @(*) begin
    case(alu_op)
        2'b00: alu_control = 3'b000; // ADD for load/store
        2'b01: alu_control = 3'b001; // SUB for branch
        2'b10: begin // R-type instructions
            case(funct3)
                3'b000: alu_control = r_type ? 3'b001 : 3'b000; // SUB/ADD
                3'b010: alu_control = 3'b101; // SLT
                3'b110: alu_control = 3'b011; // OR
                3'b111: alu_control = 3'b010; // AND
                default: alu_control = 3'bxxx; // Undefined
            endcase
        end
        default: alu_control = 3'bxxx; // Undefined
    endcase
end

endmodule
