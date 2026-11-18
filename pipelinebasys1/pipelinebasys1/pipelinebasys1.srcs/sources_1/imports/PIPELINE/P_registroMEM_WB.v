`timescale 1ns / 1ps
// MEM/WB
module MEM_WB(
    input               CLK,
    // control from MEM
    input               RegWriteM,
    input       [1:0]   ResultSrcM,
    // data from MEM
    input  [31:0]       ReadDataM,
    input  [31:0]       ALUResultM,
    input  [31:0]       PCPlus4M,
    input  [4:0]        RdM,
    // outputs to WB
    output reg          RegWriteW,
    output reg  [1:0]   ResultSrcW,
    output reg [31:0]   ReadDataW,
    output reg [31:0]   ALUResultW,
    output reg [31:0]   PCPlus4W,
    output reg [4:0]    RdW
);
    always @(posedge CLK) begin
        RegWriteW  <= RegWriteM;
        ResultSrcW <= ResultSrcM;
        ReadDataW  <= ReadDataM;
        ALUResultW <= ALUResultM;
        PCPlus4W   <= PCPlus4M;
        RdW        <= RdM;
    end
endmodule
