`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 08:48:21
// Design Name: 
// Module Name: PCplus
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
//PCplus
module PCplus (
    input [31:0] PC,
    output [31:0] PCPlus4
);
    assign PCPlus4 = PC + 32'd4;
endmodule