`timescale 1ns / 1ps

module tbmain;
    reg clk;
    reg reset;
    wire [31:0] PC_Debug;
    wire [31:0] ALU_Debug;
    
    // Instancia del procesador
    main CPU (
        .CLK(clk),
        .RST(reset),
        .PC_Debug(PC_Debug),
        .ALU_Debug(ALU_Debug)
    );
    
    // Reloj
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("main_tb.vcd");
        $dumpvars(0, tbmain);
        
        clk = 0;
        reset = 1;
        
        #20;
        reset = 0;
        
        #2000;
        $finish;
    end
endmodule