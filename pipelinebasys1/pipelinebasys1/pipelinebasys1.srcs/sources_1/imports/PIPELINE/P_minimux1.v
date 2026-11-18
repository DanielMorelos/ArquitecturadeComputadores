`timescale 1ns / 1ps
//Mini mux 1
module minimux1 (
	input [1:0] ForwarAB,
    input  [31:0] RD1E,
    input  [31:0] Resultw,
	input [31:0] ALUResultM,
    output reg [31:0] SrcAE
);
always @(*) begin
    case (ForwarAB)
        2'b00: SrcAE = RD1E;  
        2'b01: SrcAE = Resultw;   
        2'b10: SrcAE = ALUResultM;    
        default: SrcAE = 32'b0;
    endcase
end

endmodule