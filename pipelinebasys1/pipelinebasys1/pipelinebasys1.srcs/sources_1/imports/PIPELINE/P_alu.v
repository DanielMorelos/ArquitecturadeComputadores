`timescale 1ns / 1ps
//Alu
module alu (
    input  [31:0] SrcAE,
    input  [31:0] SrcBE,
    input  [3:0]  ALUControlD,
    output reg [31:0] ALUResultE,
	output ZeroE,
	output Flag2E
);
always @(*) begin
    case (ALUControlD)
        4'b0000: ALUResultE = SrcAE + SrcBE;   // suma
        4'b0001: ALUResultE = SrcAE - SrcBE;   // resta
        4'b0010: ALUResultE = SrcAE & SrcBE;   // AND
        4'b0011: ALUResultE = SrcAE | SrcBE;   // OR
		4'b0100: ALUResultE =SrcAE^SrcBE;//xor
		4'b0101: ALUResultE =(SrcAE < SrcBE) ? 32'b1 : 32'b0;//slt
		4'b0110: ALUResultE =SrcAE<<SrcBE[4:0];//sll
		4'b0111: ALUResultE = SrcAE>>>SrcBE[4:0];//sra
		4'b1000: ALUResultE =SrcAE>>SrcBE[4:0];//srl
        default: ALUResultE = 32'b0;
    endcase
end
assign ZeroE = (ALUResultE == 32'b0);// Zero=1 si el resultado es cero(para beq y bne)
assign Flag2E= ALUResultE[31];  // 1 si el resultado es negativo
endmodule
