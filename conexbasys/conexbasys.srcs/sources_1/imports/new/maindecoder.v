`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 18:02:03
// Design Name: 
// Module Name: maindecoder
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


//Main Decoder
module maindecoder (
    input [6:0] op,    // Opcode
	output reg Branch,
	output reg RegWrite,
	output reg MemWrite,
	output reg [1:0] ResultSrc,
	output reg ALUSrc,
	output reg [2:0] ImmSrc,
	output reg [1:0] ALUOp
);

    always @(*) begin
        // Valores por defecto
        Branch = 0;
        RegWrite = 0;
        MemWrite = 0;
        ResultSrc = 2'b00;
        ALUSrc = 0;
        ImmSrc = 3'b000;
        ALUOp = 2'b00;

        case (op)
            // R-type (ADD, SUB, AND, OR, SLT...)
            7'd51: begin
                RegWrite  = 1;
                ALUSrc    = 0;    //Para SrcB
                ResultSrc = 2'b00;    //Para mux final
                ALUOp     = 2'b10;   
            end

            // I-type (ADDI, ANDI, ORI, etc.)
            7'd19: begin
                RegWrite  = 1;
                ALUSrc = 1;    
                ImmSrc = 3'b000;    // Tipo I
                ResultSrc = 2'b00;
                //ALUOp = 2'b10;
            end
            // LW
            7'd3: begin
                RegWrite  = 1;
                MemWrite  = 0;
                ALUSrc    = 1;    
                ImmSrc    = 3'b000;    // Tipo I
                ResultSrc = 2'b01;    // Dato desde memoria
                ALUOp     = 2'b00;    // Operación suma
            end

            // SW
            7'd35: begin
                RegWrite  = 0;
                MemWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b001;    // Tipo S
                ALUOp     = 2'b00;
            end

            // BEQ
            7'd99: begin
                Branch    = 1;
                RegWrite  = 0;
                ALUSrc    = 0;
                ImmSrc    = 3'b010;    // Tipo B
                ALUOp     = 2'b01;    // Comparación
            end

            // JAL
            7'd111: begin
                Branch    = 1;
                RegWrite  = 1;
                ALUSrc    = 1;    // PC + inmediato
                ImmSrc    = 3'b101;    // Tipo J
                ResultSrc = 2'b10;    // PC + 4
                ALUOp     = 2'b00;
            end

            // LUI
            7'd55: begin
                RegWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b101;    // U-type (20 bits)
                ResultSrc = 2'b00;
                ALUOp     = 2'b00;
            end

            default: begin
                // Señales en 0 por defecto
            end
        endcase
    end

endmodule