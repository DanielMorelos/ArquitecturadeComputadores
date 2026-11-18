module mem_3
	# (parameter N=4, M=8)
	(
	input CLK,				
	input [N-1:0] dir,		
	output reg [M-1:0] data_out_3	
	);
reg [M-1:0] mem_3 [0: (2**N)-1];

always @ (posedge CLK)
 data_out_3 <= mem_3[dir];
  initial begin
        mem_3[0]  = 8'h05;
        mem_3[1]  = 8'h05;
        mem_3[2]  = 8'h04;
        mem_3[3]  = 8'h5C;
        mem_3[4]  = 8'h08;
        mem_3[5]  = 8'h42;
        mem_3[6]  = 8'h05;
        mem_3[7]  = 8'h00;
        mem_3[8]  = 8'h05;
        mem_3[9]  = 8'h00;
        mem_3[10] = 8'h00;
        mem_3[11] = 8'h00;
        mem_3[12] = 8'h00;
        mem_3[13] = 8'h00;
        mem_3[14] = 8'h00;
        mem_3[15] = 8'h00;
    end
endmodule