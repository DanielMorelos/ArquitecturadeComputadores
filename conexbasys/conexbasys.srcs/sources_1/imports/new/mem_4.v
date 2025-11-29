module mem_4
	# (parameter N=4, M=8)
	(
	input CLK,				
	input [N-1:0] dir,		
	output reg [M-1:0] data_out_4	
	);
reg [M-1:0] mem_4 [0: (2**N)-1];

always @ (posedge CLK)
 data_out_4 <= mem_4[dir];

    initial begin
        mem_4[0]  = 8'hB3;
    end
endmodule