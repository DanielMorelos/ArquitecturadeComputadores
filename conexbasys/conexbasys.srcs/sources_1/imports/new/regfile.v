`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 09:16:56
// Design Name: 
// Module Name: regfile
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
//register file

module regfile (
    input wire  ext_x1,    // valor externo que forzará x1
    input wire  ext_x2,     // valor externo que forzará x2
    input  wire        CLK,      // Reloj
    input  wire        WE3,      // Señal de escritura (RegWrite)
    input  wire [4:0]  A1,       // Dirección registro fuente 1
    input  wire [4:0]  A2,       // Dirección registro fuente 2
    input  wire [4:0]  A3,       // Dirección registro destino
    input  wire [31:0] WD3,      // Dato a escribir (Write Data)
    output wire [31:0] RD1,      // Dato leído de fuente 1
    output wire [31:0] RD2       // Dato leído de fuente 2
);

    // Banco de 32 registros de 32 bits
    reg [31:0] regs [0:31];

    integer i;
    initial begin
        // Inicializa todos los registros a 0
        for (i = 0; i < 32; i = i + 1)
            regs[i] = 32'b0;
    end

    // Escritura sincronizada al flanco positivo de reloj
    // No se permite escritura en x0 (registro 0 siempre es cero)
    always @(posedge CLK) begin
        if (WE3 && (A3 != 5'b00000))
            regs[A3] <= WD3;
    end

    // Lectura combinacional
    // Si se solicita leer x0, devuelve 0 sin acceder al banco de registros
    //assign RD1 = (A1 == 5'b00000) ? 32'b0 : regs[A1];
    //assign RD2 = (A2 == 5'b00000) ? 32'b0 : regs[A2];
    assign RD1 = (A1 == 5'd0) ? 32'b0 :
             (A1 == 5'd1) ? ext_x1 :
             (A1 == 5'd2) ? ext_x2 :
             regs[A1];

    assign RD2 = (A2 == 5'd0) ? 32'b0 :
             (A2 == 5'd1) ? ext_x1 :
             (A2 == 5'd2) ? ext_x2 :
             regs[A2];

endmodule
