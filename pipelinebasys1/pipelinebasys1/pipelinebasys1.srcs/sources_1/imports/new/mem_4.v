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
        mem_4[0]  = 8'h13;
        mem_4[1]  = 8'h13;
        mem_4[2]  = 8'h13;
        mem_4[3]  = 8'hE3;
        mem_4[4]  = 8'h63;
        mem_4[5]  = 8'h63;
        mem_4[6]  = 8'h13;
        mem_4[7]  = 8'h6F;
        mem_4[8]  = 8'h13;
        mem_4[9]  = 8'h00;
        mem_4[10] = 8'h00;
        mem_4[11] = 8'h00;
        mem_4[12] = 8'h00;
        mem_4[13] = 8'h00;
        mem_4[14] = 8'h00;
        mem_4[15] = 8'h00;
    end
endmodule