module main_decoder(
    input wire [6:0] opcode,
    output reg mem_write,
    output reg reg_write,
    output reg[1:0] imm_src,
    output reg[1:0] result_src,
    output reg[1:0] alu_op,
    output reg branch,
    output reg jump,
    output reg alu_src
);

always @(*) begin
    case(opcode)
       7'b0110011: begin // R-type
            mem_write = 0;
            reg_write = 1;
            imm_src = 2'bxx; // Not used
            result_src = 2'b00; // ALU result
            alu_op = 2'b10; // ALU operation determined by funct3 and funct7
            branch = 0;
            jump = 0;
            alu_src = 0; // Second ALU operand from register
        end
        7'b0000011: begin // Load
            mem_write = 0;
            reg_write = 1;
            imm_src = 2'b00; // I-type immediate
            result_src = 2'b01; // Data from memory
            alu_op = 2'b00; // ALU performs addition for address calculation
            branch = 0;
            jump = 0;
            alu_src = 1; // Second ALU operand is immediate
        end
        7'b0100011: begin // Store
            mem_write = 1;
            reg_write = 0;
            imm_src = 2'b01; // S-type immediate
            result_src = 2'bxx; // Not used
            alu_op = 2'b00; // ALU performs addition for address calculation
            branch = 0;
            jump = 0;
            alu_src = 1; // Second ALU operand is immediate
        end
        7'b1100011: begin // Branch
            mem_write = 0;
            reg_write = 0;
            imm_src = 2'b10; // B-type immediate
            result_src = 2'bxx; // Not used
            alu_op = 2'b01; // ALU performs subtraction for comparison
            branch = 1;
            jump = 0;
            alu_src = 0; // Second ALU operand from register
        end
        7'b1101111: begin // Jump and Link
            mem_write = 0;
            reg_write = 1;
            imm_src = 2'b11; // J-type immediate
            result_src = 2'b10; // PC + 4
            alu_op = 2'bxx; // Not used
            branch = 0;
            jump = 1;
            alu_src = 0; // Second ALU operand from register
        end
        7'b0010011: begin // Immediate ALU operations (I-type)
            mem_write = 0;
            reg_write = 1;
            imm_src = 2'b00; // I-type immediate
            result_src = 2'b00; // ALU result
            alu_op = 2'b10; // ALU operation determined by funct3
            branch = 0;
            jump = 0;
            alu_src = 1; // Second ALU operand is immediate
        end
        default: begin // Default case for unsupported opcodes
            mem_write = 0;
            reg_write = 0;
            imm_src = 2'bxx; // Not used
            result_src = 2'bxx; // Not used
            alu_op = 2'bxx; // Not used
            branch = 0;
            jump = 0;
            alu_src = 0; // Second ALU operand from register
        end
    endcase
end

endmodule
