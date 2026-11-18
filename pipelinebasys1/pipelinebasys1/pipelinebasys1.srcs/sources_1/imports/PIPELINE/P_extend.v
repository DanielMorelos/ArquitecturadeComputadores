`timescale 1ns / 1ps
//Extend
module extend (
    input  [31:0] InstrD,
    input  [2:0] ImmSrcD,
    output reg [31:0] ImmExtD
);
always @(*) begin
    case (ImmSrcD)
        3'b000:ImmExtD = {{20{InstrD[31]}}, InstrD[31:20]}; // I-Type (ADDI, LW, JALR...)  
        3'b001:ImmExtD = {{20{InstrD[31]}}, InstrD[31:25], InstrD[11:7]}; // S-Type (SW, SH, SB...)
        3'b010:ImmExtD = {{19{InstrD[31]}}, InstrD[31], InstrD[7], InstrD[30:25], InstrD[11:8], 1'b0};   // B-Type (BEQ, BNE, BLT...) 
        3'b011:ImmExtD = {InstrD[31:12], 12'b0};	// U-Type (LUI, AUIPC)
        3'b101:ImmExtD = {{11{InstrD[31]}}, InstrD[31], InstrD[19:12], InstrD[20], InstrD[30:21], 1'b0}; // J-Type (JAL)
        default:ImmExtD = 32'b0;
    endcase
end
endmodule