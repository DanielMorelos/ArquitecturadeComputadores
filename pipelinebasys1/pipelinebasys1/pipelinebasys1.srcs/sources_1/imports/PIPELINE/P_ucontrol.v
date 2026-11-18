`timescale 1ns / 1ps

module Pucontrol (
    input  [6:0] op,        // Instr[6:0]
    input  [2:0] funct3,    // Instr[14:12]
    input  [6:0] funct7,    // Instr[31:25]
    
    output       RegWriteD,
    output       MemWriteD,
    output [1:0] ResultSrcD,
    output       ALUSrcD,
    output [2:0] ImmSrcD,
    output [1:0] ALUOpD,
    output [3:0] ALUControlD,
    output       BranchD   
);

    wire RegWrite;
    wire MemWrite;
    wire [1:0] ResultSrc;
    wire ALUSrc;
    wire [2:0] ImmSrc;
    wire [1:0] ALUOp;
    wire Branch;            

    // DECODIFICADOR PRINCIPAL
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

    // DECODIFICADOR DE LA ALU
    ALUDecoder U1 (
        .funct3(funct3),
        .funct7(funct7),
        .ALUOp(ALUOp),
        .ALUControl(ALUControlD)
    );

    // Asignación de señales hacia ID/EX
    assign RegWriteD  = RegWrite;
    assign MemWriteD  = MemWrite;
    assign ResultSrcD = ResultSrc;
    assign ALUSrcD    = ALUSrc;
    assign ImmSrcD    = ImmSrc;
    assign ALUOpD     = ALUOp;
    assign BranchD    = Branch;     //

endmodule