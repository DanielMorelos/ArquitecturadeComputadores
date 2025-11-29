`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 08:45:32
// Design Name: 
// Module Name: mux4
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


//Mux del final
module mux4 (
	input [1:0] ResultSrc,
    input  [31:0] ALUResult,
    input  [31:0] ReadData,
	input [31:0] PCPlus4,
	input [31:0] ImmExt,
    output reg [31:0] Result
);
always @(*) begin
    case (ResultSrc)
        2'b00: Result = ALUResult;  // desde ALU
        2'b01: Result = ReadData;   // desde memoria
        2'b10: Result = PCPlus4;    // PC + 4 (para JAL/JALR)
        2'b11: Result = ImmExt;     // inmediato (ej: LUI/AUIPC) REVISAR
        default: Result = 32'b0;
    endcase
end

endmodule

