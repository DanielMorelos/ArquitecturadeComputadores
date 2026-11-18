`timescale 1ns / 1ps
//Mux del final
module mux4 (
	input [1:0] ResultSrcW,
    input  [31:0] ALUResultW,
    input  [31:0] ReadDataW,
	input [31:0] PCPlus4W,
	input [31:0] ImmExtW,
    output reg [31:0] ResultW
);
always @(*) begin
    case (ResultSrcW)
        2'b00: ResultW = ALUResultW;  // desde ALU
        2'b01: ResultW = ReadDataW;   // desde memoria
        2'b10: ResultW = PCPlus4W;    // PC + 4 (para JAL/JALR)
        2'b11: ResultW = ImmExtW;     // inmediato (ej: LUI/AUIPC) REVISAR
        default: ResultW = 32'b0;
    endcase
end

endmodule