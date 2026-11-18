`timescale 1ns / 1ps

//Extend
module extend (
    input  [31:7] Instr,
    input  [2:0] ImmSrc,
    output reg [31:0] ImmExt
);
always @(*) begin
    case (ImmSrc)
        3'b000:ImmExt = {{20{Instr[31]}}, Instr[31:20]}; // I-Type (ADDI, LW, JALR...)  
        3'b001:ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]}; // S-Type (SW, SH, SB...)
        3'b010:ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};   // B-Type (BEQ, BNE, BLT...) 
        3'b011:ImmExt = {Instr[31:12], 12'b0};	// U-Type (LUI, AUIPC)
        3'b101:ImmExt = {{11{Instr[31]}}, Instr[31], Instr[19:12], Instr[20], Instr[30:21], 1'b0}; // J-Type (JAL)
        default:ImmExt = 32'b0;
    endcase
end
endmodule