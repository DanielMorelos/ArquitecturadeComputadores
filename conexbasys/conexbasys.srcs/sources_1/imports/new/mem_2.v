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
    end

  
endmodule