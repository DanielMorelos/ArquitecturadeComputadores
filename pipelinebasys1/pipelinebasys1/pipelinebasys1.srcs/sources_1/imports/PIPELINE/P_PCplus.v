`timescale 1ns / 1ps
module PCplus (
    input [31:0] PCF,
    output [31:0] PCPlus4F
);
    assign PCPlus4F = PCF + 32'd4;
endmodule