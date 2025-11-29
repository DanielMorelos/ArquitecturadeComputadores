`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 09:43:15
// Design Name: 
// Module Name: mem_1
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

module mem_1
	# (parameter N=4, M=8)
	(
	input CLK,				
	input [N-1:0] dir,		
	output reg [M-1:0] data_out_1	
	);
reg [M-1:0] mem_1 [0: (2**N)-1];

 // Inicialización de la memoria
    initial begin
        mem_1[0]  = 8'h00;
    end

    // Lectura síncrona
    always @(posedge CLK)
        data_out_1 <= mem_1[dir];

endmodule
