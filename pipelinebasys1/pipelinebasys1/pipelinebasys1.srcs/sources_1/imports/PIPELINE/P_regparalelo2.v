`timescale 1ns / 1ps
// Registro paralelo para PC (entrada PCF_next -> salida PCF)
module regparalelo2 (
    input  CLK,
    input  [31:0] PCF_next,
    input  RST, 
    output reg [31:0] PCF
);
always @(posedge CLK) begin
    if (RST)
        PCF <= 32'd0;
    else
        PCF <= PCF_next;
end
endmodule