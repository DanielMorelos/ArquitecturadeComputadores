`timescale 1ns / 1ps
//Mini mux 2
module minimux2 (
	input [1:0] ForwarBE,
    input  [31:0] RD2E,
    input  [31:0] Resultw,
	input [31:0] ALUResultM,
    output reg [31:0] SrcBE
);
always @(*) begin
    case (ForwarBE)
        2'b00: SrcBE = RD2E;  
        2'b01: SrcBE = Resultw;   
        2'b10: SrcBE = ALUResultM;    
        default: SrcBE = 32'b0;
    endcase
end

endmodule

