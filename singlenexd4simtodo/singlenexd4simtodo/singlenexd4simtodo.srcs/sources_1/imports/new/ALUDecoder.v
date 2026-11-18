`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 17:41:37
// Design Name: 
// Module Name: ALUDecoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//ALUDecoder
module ALUDecoder (
    //input [6:0] op,        // Opcode
    input [2:0] funct3,    // funct3 field
    input [6:0] funct7,    // funct7 field
    input [1:0] ALUOp,     // ALUOp desde la unidad de control
    output reg [3:0] ALUControl // Señal final de control para la ALU
);

    always @(*) begin
        case (ALUOp)
            2'b00: begin 
                // Tipo de carga/almacenamiento (lw, sw) suma
                ALUControl = 4'b0000; 
            end

            2'b01: begin 
                // Tipo branch (beq, bne, bge, etc.)
                case (funct3)
                    3'b000: ALUControl = 4'b0001; // beq: resta
                    3'b001: ALUControl = 4'b0001; // bne: resta
                    //'b100: ALUControl = 4'b0001; // blt: 
                    3'b101: ALUControl = 4'b0001; // bge: resta
                    default: ALUControl = 4'b0001;
                endcase
            end

            2'b10: begin 
                // Tipo R (funct7 y funct3 determinan la operación)
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            ALUControl = 4'b0001; // sub
                        else
                            ALUControl = 4'b0000; // add
                    end
                    3'b111: ALUControl = 4'b0010; // and
                    3'b110: ALUControl = 4'b0011; // or
                    3'b100: ALUControl = 4'b0100; // xor
                    3'b001: ALUControl = 4'b0110; // sll
                    3'b101: begin
                        if (funct7 == 7'b0100000)
                            ALUControl = 4'b0111; // sra
                        else
                            ALUControl = 4'b1000; // srl
                    end
                    3'b010: ALUControl = 4'b0101; // slt
                    default: ALUControl = 4'b0000;
                endcase

            end

            default: ALUControl = 4'b0000;
        endcase
    end

endmodule