`timescale 1ns / 1ps

module ID_EX(
    input               CLK,
    input               flush,

    // Señales de control desde ID 
    input               RegWriteD,
    input               MemWriteD,
    input       [1:0]   ResultSrcD,
    input       [1:0]   ALUSrcD,
    input       [2:0]   ImmSrcD,
    input       [1:0]   ALUOpD,
    input       [3:0]   ALUControlD,  // Entrada desde ID

    // Señales de datos desde ID 
    input       [31:0]  PCPlus4D,
    input       [31:0]  RD1D,
    input       [31:0]  RD2D,
    input       [31:0]  ImmExtD,
    input       [4:0]   Rs1D,
    input       [4:0]   Rs2D,
    input       [4:0]   RdD,

    // Salidas hacia EX 
    output reg          RegWriteE,
    output reg          MemWriteE,
    output reg  [1:0]   ResultSrcE,
    output reg  [1:0]   ALUSrcE,
    output reg  [2:0]   ImmSrcE,
    output reg  [1:0]   ALUOpE,
    output reg  [3:0]   ALUControlE,  // Salida hacia EX

    output reg [31:0]   PCPlus4E,
    output reg [31:0]   RD1E,
    output reg [31:0]   RD2E,
    output reg [31:0]   ImmExtE,
    output reg [4:0]    Rs1E,
    output reg [4:0]    Rs2E,
    output reg [4:0]    RdE
);

always @(posedge CLK) begin
    if (flush) begin
        // Limpia señales de control
        RegWriteE   <= 0;
        MemWriteE   <= 0;
        ResultSrcE  <= 0;
        ALUSrcE     <= 0;
        ImmSrcE     <= 0;
        ALUOpE      <= 0;
        ALUControlE <= 0;

        // Limpia señales de datos
        PCPlus4E <= 0;
        RD1E     <= 0;
        RD2E     <= 0;
        ImmExtE  <= 0;
        Rs1E     <= 0;
        Rs2E     <= 0;
        RdE      <= 0;

    end else begin
        // Pasa señales de control
        RegWriteE   <= RegWriteD;
        MemWriteE   <= MemWriteD;
        ResultSrcE  <= ResultSrcD;
        ALUSrcE     <= ALUSrcD;
        ImmSrcE     <= ImmSrcD;
        ALUOpE      <= ALUOpD;
        ALUControlE <= ALUControlD;   // Pasa ALUControl de D a E

        // Pasa señales de datos
        PCPlus4E <= PCPlus4D;
        RD1E     <= RD1D;
        RD2E     <= RD2D;
        ImmExtE  <= ImmExtD;
        Rs1E     <= Rs1D;
        Rs2E     <= Rs2D;
        RdE      <= RdD;
    end
end
endmodule