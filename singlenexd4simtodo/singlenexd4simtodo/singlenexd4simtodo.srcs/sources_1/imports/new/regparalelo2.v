`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 09:03:14
// Design Name: 
// Module Name: regparalelo2
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

//registro paralelo paralelo
module regparalelo2 (
    input  CLK,
    input  RST,          // reset síncrono
    input  [31:0] PCNext,
    output reg [31:0] PC
);

always @(posedge CLK) begin
    if (RST)
        PC <= 32'h00000000;
    else
        PC <= PCNext;
end

endmodule