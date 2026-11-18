`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 08:40:31
// Design Name: 
// Module Name: muxm
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

//Mux de la mitad
module muxm (
	input [31:0] ImmExt,
    input  [31:0] RD2,
    input ALUSrc,
    output  [31:0] SrcB
);
assign SrcB = (ALUSrc)? ImmExt:RD2;// Si ALUSrc=1;SrcB=ImmExt 
endmodule
