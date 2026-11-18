`timescale 1ns / 1ps
// IF/ID
module IF_ID(
    input              CLK,
    input              stall,
    input              flush,
    input  [31:0]      PCPlus4F,
    input  [31:0]      InstrF,
    output reg [31:0]  PCPlus4D,
    output reg [31:0]  InstrD
);
    always @(posedge CLK) begin
        if (flush) begin
            PCPlus4D <= 32'b0;
            InstrD   <= 32'b0;
        end else if (!stall) begin
            PCPlus4D <= PCPlus4F;
            InstrD   <= InstrF;
        end
        // si stall = 1 mantenemos valores previos (no escribir)
    end
endmodule
