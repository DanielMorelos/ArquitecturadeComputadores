`timescale 1ns / 1ps
module main(
    input  CLK,
    input RST,
    input wire  ext_x1,
    input wire  ext_x2,
    output [31:0] debug_result
);
// Entradas a la unidad de control
wire [6:0]  op;       // Instr[6:0]
wire [2:0]  funct3;   // Instr[14:12]
wire [6:0]  funct7;   // Instr[31:25] 
wire        Zero;     // bandera desde la ALU
wire        Flag2;    // bandera secundaria

// Salidas desde la unidad de control
wire PCSrc;
wire MemWrite;
wire RegWrite;
wire ALUSrc;
wire [1:0] ResultSrc;
wire [2:0] ImmSrc;
wire [3:0] ALUControl;

// --- Señales PC ---
wire [31:0] PC;
wire [31:0] PCNext;
wire [31:0] PCPlus4;
wire [31:0] PCTarget;

// Señales del register file
wire [31:0] WD3;     // dato a escribir
wire [31:0] RD1, RD2;// datos leídos

//señales extend
wire [31:0] Instr;     // Viene de la memoria de instrucciones
wire [31:0] ImmExt;    // Salida del generador de inmediato

//señales muxmedio
wire [31:0] SrcB;     // salida del muxm : entra a la ALU
// Entradas a la ALU
wire [31:0] SrcA;         // Desde regfile (RD1)

// Salidas de la ALU
wire [31:0] ALUResult;

wire [31:0] ReadData;   // dato leído desde la memoria

wire [31:0] Result;       // salida del mux final (WD3)

ucontrol ucontrol (
    .op(op),
    .funct3(funct3),
    .funct7(funct7),
    .Zero(Zero),
    .Flag2(Flag2),
    .PCSrc(PCSrc),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl)
);

mux mux(
    .PCPlus4(PCPlus4),
    .PCTarget(PCTarget),
    .PCSrc(PCSrc),
    .PCNext(PCNext)
);
regparalelo2 regparalelo2 (
    .CLK(CLK),
    .RST(RST),
    .PCNext(PCNext),
    .PC(PC)
);

PCplus PCplus (
    .PC(PC),
    .PCPlus4(PCPlus4)
);

mem_principal #(.N(6), .M(8)) mem_principal (
    .CLK(CLK),
    .dir4(PC[7:2]),         // se usan los bits [7:2] como dirección 
    .data_out_mem(Instr)    // salida de la instrucción
);

regfile regfile (
    .CLK(CLK),
    .WE3(RegWrite),
    .A1(Instr[19:15]),  // rs1
    .A2(Instr[24:20]),  // rs2
    .A3(Instr[11:7]),   // rd
    .WD3(WD3),           // dato a escribir
    .RD1(RD1),
    .RD2(RD2),
    .ext_x1(ext_x1),
    .ext_x2(ext_x2)
);

extend extend (
    .Instr(Instr[31:7]),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);

muxm muxm (
    .ImmExt(ImmExt),
    .RD2(RD2),
    .ALUSrc(ALUSrc),
    .SrcB(SrcB)
);

alu alu (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero),
    .Flag2(Flag2)
);

PCtarget PCtarget (
    .PC(PC),
    .ImmExt(ImmExt),
    .PCTarget(PCTarget)
);

datamem #(.N(5), .M(32)) datamem (
    .CLK(CLK),
    .WE(MemWrite),
    .A(ALUResult[4:0]), // usa los 5 bits bajos como dirección
    .WD(RD2),
    .RD(ReadData)
);

mux4 mux4 (
    .ResultSrc(ResultSrc),
    .ALUResult(ALUResult),
    .ReadData(ReadData),
    .PCPlus4(PCPlus4),
    .ImmExt(ImmExt),
    .Result(Result)
);

//asignaciones adicionales de la ucontrol
assign op = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7 = Instr[31:25];
assign SrcA = RD1;  // primer operando de la ALU
assign WD3 = Result; // dato que vuelve al regfile
assign debug_result = Result;  // o cualquier señal que quieras observar

endmodule