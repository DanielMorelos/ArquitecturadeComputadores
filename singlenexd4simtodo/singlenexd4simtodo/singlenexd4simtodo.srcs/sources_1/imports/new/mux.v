`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 08:34:46
// Design Name: 
// Module Name: mux
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

//Mux del inicio
module mux (
	input [31:0] PCPlus4,
    input [31:0] PCTarget,
    input PCSrc,
    output  [31:0] PCNext
);
assign PCNext = (PCSrc)? PCTarget : PCPlus4;// Si PCSrc=1;PCNext=PCTarget (salto/branch).Si PCSrc=0; PCNext=PCPlus4(ejecución secuencial)
endmodule
