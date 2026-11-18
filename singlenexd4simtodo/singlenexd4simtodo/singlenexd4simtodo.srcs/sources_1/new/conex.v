`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2025 17:28:59
// Design Name: 
// Module Name: conex
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


module conex(
    input CLK100MHZ,
    input BTNC,          // reset (o cualquier botón)
    output [15:0] LED
);

wire [31:0] debug_result;

main m0(
    .CLK(CLK100MHZ),
    .RST(BTNC),
    .debug_result(debug_result)
);

// Solo mostramos los 16 bits menos significativos
assign LED = debug_result[15:0];

endmodule
