`timescale 1ns / 1ps

module ALUDecoder (
    input  [2:0] funct3,
    input  [6:0] funct7,
    input  [1:0] ALUOp,
    output reg [3:0] ALUControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0000; // ADD (loads, stores)

            2'b01: begin // Branches
                case (funct3)
                    3'b000: ALUControl = 4'b0001; // BEQ => SUB
                    3'b001: ALUControl = 4'b0001; // BNE => SUB  
                    3'b100: ALUControl = 4'b0010; // BLT => SLT
                    3'b101: ALUControl = 4'b0011; // BGE => SLTU
                    default: ALUControl = 4'b0001;
                endcase
            end

            2'b10: begin // R-type / I-type
                case (funct3)
                    3'b000: ALUControl = (funct7[5]) ? 4'b0001 : 4'b0000; // SUB/ADD
                    3'b001: ALUControl = 4'b0100; // SLL
                    3'b010: ALUControl = 4'b0010; // SLT
                    3'b011: ALUControl = 4'b0011; // SLTU
                    3'b100: ALUControl = 4'b0101; // XOR
                    3'b101: ALUControl = (funct7[5]) ? 4'b0111 : 4'b0110; // SRA/SRL
                    3'b110: ALUControl = 4'b1000; // OR
                    3'b111: ALUControl = 4'b1001; // AND
                    default: ALUControl = 4'b0000;
                endcase
            end
            
            default: ALUControl = 4'b0000;
        endcase
    end

endmodule