`timescale 1ns / 1ps
//HazardUnit
module HazardUnit(
    input  [4:0] RS1D,
    input  [4:0] RS2D, 
    input  [4:0] RS1E,
    input  [4:0] RS2E,
    input  [1:0] ResultSrcD,   // Para saber si la instrucción en D es un load 
    input  [4:0] RdE,
    input  [4:0] RdM,
    input  [4:0] RdW,
    input        RegWriteM,
    input        RegWriteW,
    input  [1:0] ResultSrcE,   // Necesario para detectar load-use 
    
    output reg        PCWrite,
    output reg        StallF,
    output reg        StallD,
    output reg        FlushD,
    output reg        FlushE,
    output reg [1:0]  ForwardAE,
    output reg [1:0]  ForwardBE
);
    // 1) DEFAULTS
    always @(*) begin
        // Default: no stalls, no flushes
        PCWrite  = 1;
        StallF   = 0;
        StallD   = 0;
        FlushD   = 0;
        FlushE   = 0;
        // Default forwarding (00 = usar registros del banco)
        ForwardAE = 2'b00;
        ForwardBE = 2'b00;
        // 2) FORWARDING LOGIC
        // Forward A: desde MEM
        if (RegWriteM && (RdM != 0) && (RdM == RS1E))
            ForwardAE = 2'b10;
        // Forward A: desde WB
        else if (RegWriteW && (RdW != 0) && (RdW == RS1E))
            ForwardAE = 2'b01;
        // Forward B: desde MEM
        if (RegWriteM && (RdM != 0) && (RdM == RS2E))
            ForwardBE = 2'b10;
        // Forward B: desde WB
        else if (RegWriteW && (RdW != 0) && (RdW == RS2E))
            ForwardBE = 2'b01;

        // 3) LOAD-USE HAZARD (Stall)
        // Si la instrucción en EX es un LOAD:
        //   ResultSrcE = 2'b01 (dato viene de memoria)
        // Y el load está escribiendo en el registro que la instrucción en D necesita

        if (ResultSrcE == 2'b01 &&  
           ((RdE == RS1D) || (RdE == RS2D)) && (RdE != 0)) begin
            
            // Stall
            PCWrite = 0;    // detener PC
            StallF  = 1;    // congelar IF
            StallD  = 1;    // congelar ID
            FlushE  = 1;    // convertir EX 
        end
    end
endmodule