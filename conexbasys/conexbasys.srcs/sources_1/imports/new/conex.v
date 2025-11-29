`timescale 1ns / 1ps
module conex(
    input CLK100MHZ,
    input BTN0,             // reset
    input [1:0] SW,        // switches
    output [1:0] LED
);

wire [31:0] debug_result;

wire  x1_in = {24'd0, SW[0]};
wire  x2_in = {24'd0, SW[1]};

main cpu (
    .CLK(CLK100MHZ),
    .RST(BTN0),
    .ext_x1(x1_in),
    .ext_x2(x2_in),
    .debug_result(debug_result)
);

assign LED[1:0] = debug_result[1:0];

endmodule
