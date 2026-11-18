`timescale 1ns / 1ps

module mem_principal 
	# (parameter N=6, M=8) 
  (
    input CLK,
    input [N-1:0] dir4,       
    output [31:0] data_out_mem  
  );
wire [3:0]dir;
assign dir=dir4>>2;
wire [7:0] data_out_1, data_out_2, data_out_3, data_out_4;

mem_1 U0 (
.CLK(CLK), 
.dir(dir), 
.data_out_1(data_out_1));
mem_2 U1 (
.CLK(CLK), 
.dir(dir), 
.data_out_2(data_out_2));
mem_3 U2 (
.CLK(CLK), 
.dir(dir), 
.data_out_3(data_out_3));
mem_4 U3 (
.CLK(CLK), 
.dir(dir), 
.data_out_4(data_out_4));

  
assign data_out_mem = {data_out_1, data_out_2, data_out_3, data_out_4};

endmodule
