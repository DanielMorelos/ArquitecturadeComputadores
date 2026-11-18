`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 08:57:22
// Design Name: 
// Module Name: PCtarget
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

module PCtarget (
    input [31:0] PC,
	input [31:0] ImmExt,
    output [31:0] PCTarget
);
    assign PCTarget = PC + ImmExt;
endmodule
