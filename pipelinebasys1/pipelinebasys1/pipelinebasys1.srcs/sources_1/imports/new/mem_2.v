module mem_2
	# (parameter N=4, M=8)
	(
	input CLK,				
	input [N-1:0] dir,		
	output reg [M-1:0] data_out_2	
	);
reg [M-1:0] mem_2 [0: (2**N)-1];

always @ (posedge CLK)
 data_out_2 <= mem_2[dir];

initial begin
        mem_2[0]  = 8'h20;
        mem_2[1]  = 8'h75;
        mem_2[2]  = 8'h14;
        mem_2[3]  = 8'h85;
        mem_2[4]  = 8'h05;
        mem_2[5]  = 8'h05;
        mem_2[6]  = 8'h00;
        mem_2[7]  = 8'h80;
        mem_2[8]  = 8'h01;
        mem_2[9]  = 8'h00;
        mem_2[10] = 8'h00;
        mem_2[11] = 8'h00;
        mem_2[12] = 8'h00;
        mem_2[13] = 8'h00;
        mem_2[14] = 8'h00;
        mem_2[15] = 8'h00;
    end

  
endmodule