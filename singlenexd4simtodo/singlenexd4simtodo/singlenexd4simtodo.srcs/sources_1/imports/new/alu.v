`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 08:23:31
// Design Name: 
// Module Name: alu
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

//Alu
module alu (
    input  [31:0] SrcA,
    input  [31:0] SrcB,
    input  [3:0]  ALUControl,
    output reg [31:0] ALUResult,
	output Zero,
	output Flag2
);
always @(*) begin
    case (ALUControl)
        4'b0000: ALUResult = SrcA + SrcB;   // suma
        4'b0001: ALUResult = SrcA - SrcB;   // resta
        4'b0010: ALUResult = SrcA & SrcB;   // AND
        4'b0011: ALUResult = SrcA | SrcB;   // OR
		4'b0100: ALUResult=SrcA^SrcB;//xor
		4'b0101: ALUResult=(SrcA < SrcB) ? 32'b1 : 32'b0;//slt
		4'b0110: ALUResult=SrcA<<SrcB[4:0];//sll
		4'b0111: ALUResult= SrcA>>>SrcB[4:0];//sra
		4'b1000: ALUResult=SrcA>>SrcB[4:0];//srl
        default: ALUResult = 32'b0;
    endcase
end
assign Zero = (ALUResult == 32'b0);// Zero=1 si el resultado es cero(para beq y bne)
assign Flag2= ALUResult[31];  // 1 si el resultado es negativo
endmodule
