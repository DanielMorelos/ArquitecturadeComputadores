`timescale 1ns / 1ps
// Mux del inicio (elige PC next)
module mux(
    input [31:0] PCPlus4F,
    input [31:0] PCTargetE,
    input PCSrcE,
    output reg [31:0] PCF_next
);

always @(*) begin
    if (PCSrcE)
        PCF_next = PCTargetE;
    else
        PCF_next = PCPlus4F;
end

endmodule