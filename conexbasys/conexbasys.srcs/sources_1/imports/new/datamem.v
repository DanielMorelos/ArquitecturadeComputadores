`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2025 11:22:39
// Design Name: 
// Module Name: datamem
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
//Memoria de Datos
module datamem
    #(parameter N = 5,            // número de bits de dirección (2^N palabras)
      parameter M = 32)           // ancho de palabra (bits)
    (
      input CLK,                   // reloj
      input WE,                    // write enable (1 = escribir)
      input [N-1:0] A,             // dirección de palabra (N bits)
      input [M-1:0] WD,     // dato a escribir en memoria
      output reg [M-1:0] RD  // dato leído desde memoria
    );
	reg [M-1:0] my_mem [2**N-1:0];
	always @ (posedge CLK) 
		if (WE) my_mem[A] <= WD;			
    always @(*)
        RD = my_mem[A];
endmodule
