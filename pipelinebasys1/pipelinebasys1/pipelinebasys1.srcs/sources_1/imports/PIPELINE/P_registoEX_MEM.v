`timescale 1ns / 1ps
// EX/MEM
module EX_MEM(
    input               CLK,
    // control from EX
    input               RegWriteE,
    input               MemWriteE,
    input       [1:0]   ResultSrcE,
    // data from EX
    input  [31:0]       ALUResultE,
    input  [31:0]       RD2E,
    input  [31:0]       PCPlus4E,
    input  [4:0]        RdE,
    // outputs to MEM
    output reg          RegWriteM,
    output reg          MemWriteM,
    output reg  [1:0]   ResultSrcM,
    output reg [31:0]   ALUResultM,
    output reg [31:0]   RD2M,
    output reg [31:0]   PCPlus4M,
    output reg [4:0]    RdM
);
    always @(posedge CLK) begin
        RegWriteM <= RegWriteE;
        MemWriteM <= MemWriteE;
        ResultSrcM<= ResultSrcE;
        ALUResultM<= ALUResultE;
        RD2M      <= RD2E;
        PCPlus4M  <= PCPlus4E;
        RdM       <= RdE;
    end
    
endmodule
