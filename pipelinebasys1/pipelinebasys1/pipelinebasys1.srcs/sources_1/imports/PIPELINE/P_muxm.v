`timescale 1ns / 1ps
//Mux de la mitad
module muxm (
	input [31:0] ImmExtE,
    input  [31:0] RE,
    input ALUSrcD,
    output  [31:0] SrcBE
);
assign SrcBE = (ALUSrcD)? ImmExtE:RE;// Si ALUSrc=1;SrcB=ImmExt 
endmodule