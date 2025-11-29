`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 18:10:11
// Design Name: 
// Module Name: ucontrol
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


//Unidad de Control
module ucontrol (
    input [6:0] op,        // Instr[6:0]
    input [2:0] funct3,    // Instr[14:12]
    input [6:0] funct7,    // bit 30 de Instr
    input Zero,
    input Flag2,
    output PCSrc,
    output MemWrite,
    output RegWrite,
    output ALUSrc,
    output [1:0] ResultSrc,
    output [2:0] ImmSrc,
    output [3:0] ALUControl
);
wire Branch;
wire [1:0] ALUOp;
maindecoder U0 ( 
    .op(op), 
    .Branch(Branch),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
);
ALUDecoder U1 (
    //.op(op),
    .funct3(funct3),
    .funct7(funct7), 
    .ALUOp(ALUOp), 
    .ALUControl(ALUControl)
);
assign PCSrc = (Zero && Branch) || (~Flag2 && Branch);
endmodule