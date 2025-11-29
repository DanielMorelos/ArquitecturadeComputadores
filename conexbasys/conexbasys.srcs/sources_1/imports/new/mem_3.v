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
        mem_3[0]  = 8'h81;
    end
endmodule