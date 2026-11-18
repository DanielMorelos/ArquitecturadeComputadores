//register file
`timescale 1ns / 1ps

module regfile(
    input [4:0] A1,//5 bits=32 posiciones
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WE3,
    input CLK,
    output reg [31:0] RD1,
    output reg [31:0] RD2
    );
reg [31:0] regs [0:31];//vector de 32 registros de 32 bits (reg bits regs vectorsize)

always @(*) begin
    regs[0] <= 32'd0;
    RD1 = regs[A1];//Guarda lo que hay en el registro de la posicion A1 en RD1
end
always @(*) begin
    RD2 = regs[A2];//Guarda lo que hay en el registro de la posicion A2 en RD2
end

always @(posedge CLK) begin
    if (WE3 && A3 != 5'd0) begin// Si WE3=1 y A3 es diferente de 0(el registro zero no se puede modificar)
        regs[A3] <= WD3;// guarda en el registro de la posicion A3 lo que hay en WD3
    end
end
endmodule