`timescale 1ns / 1ps

module main(
    input  wire CLK,
    input  wire RST,
    output wire [31:0] PC_Debug,
    output wire [31:0] ALU_Debug
);

wire PCSrcE;
wire [31:0] ResultW;
wire [31:0] ImmExtW;
wire [31:0] PCE;
wire [31:0] ALUResultE;
wire [31:0] ReadDataM;
wire [4:0] RS1D;
wire [4:0] RS2D;
wire [3:0] ALUControlD;
assign PCSrcE = ZeroE;        // Ejemplo simple: branch cuando ZeroE=1
//assign PCSrcE = BranchE & ZeroE;  // Ejemplo para BEQ
// Para debug
assign PC_Debug = PCF;
assign ALU_Debug = ALUResultE;

// --- MÓDULO PC ---
wire [31:0] PCF;
wire [31:0] PCF_next;
regparalelo2 pc_reg_inst (
    .CLK(CLK),
    .PCF_next(PCF_next),
    .RST(RST),
    .PCF(PCF)
);
// --- PC TARGET PARA SALTOS ---
wire [31:0] PCTargetE;

PCtarget pc_target_unit (
    .PCE        (PCPlus4E - 4),  // PC actual = PCPlus4E - 4
    .ImmExtE    (ImmExtE),
    .PCTargetE  (PCTargetE)
);
// --- MEMORIA DE INSTRUCCIONES ---
wire [31:0] InstrF;
mem_principal imem (
    .CLK(CLK),
    .dir4(PCF),
    .data_out_mem(InstrF)
);

// --- PC + 4 ---
wire [31:0] PCPlus4F;
PCplus pc_plus_unit (
    .PCF(PCF),
    .PCPlus4F(PCPlus4F)
);

// --- PIPELINE IF/ID ---
wire [31:0] InstrD;
wire [31:0] PCPlus4D;
wire stallD;
wire flushD;

IF_ID if_id_reg (
    .CLK(CLK),
    .stall(stallD),
    .flush(flushD),
    .PCPlus4F(PCPlus4F),
    .InstrF(InstrF),
    .PCPlus4D(PCPlus4D),
    .InstrD(InstrD)
);

// --- UNIDAD DE CONTROL ---
wire RegWriteD, MemWriteD;
wire [1:0] ResultSrcD, ALUSrcD, ALUOpD;
wire [2:0] ImmSrcD;
wire BranchD;

Pucontrol control_unit (
    .op         (opD),
    .funct3     (funct3D),
    .funct7     (funct7D),
    .RegWriteD  (RegWriteD),
    .MemWriteD  (MemWriteD),
    .ResultSrcD (ResultSrcD),
    .ALUSrcD    (ALUSrcD),
    .ImmSrcD    (ImmSrcD),
    .ALUOpD     (ALUOpD),
    .ALUControlD(ALUControlD),
    .BranchD    (BranchD)     
);



// --- EXTEND ---
wire [31:0] ImmExtD;
extend immEXT(
    .InstrD(InstrD),
    .ImmSrcD(ImmSrcD),
    .ImmExtD(ImmExtD)
);

// --- REGISTER FILE ---
wire [31:0] RD1D, RD2D;
wire [4:0] RdD = InstrD[11:7];  // Campo rd

regfile rf (
    .A1(RS1D),
    .A2(RS2D),
    .A3(RdW),
    .WD3(ResultW),
    .WE3(RegWriteW),
    .CLK(CLK),
    .RD1(RD1D),
    .RD2(RD2D)
);

// --- PIPELINE ID/EX ---
wire RegWriteE, MemWriteE;
wire [1:0] ResultSrcE, ALUSrcE;
wire [31:0] RD1E, RD2E, ImmExtE;
wire [4:0] Rs1E, Rs2E, RdE;
wire flushE;

ID_EX id_ex_reg (
    .CLK(CLK),
    .flush(flushE),
    .RegWriteD(RegWriteD),
    .MemWriteD(MemWriteD),
    .ResultSrcD(ResultSrcD),
    .ALUSrcD(ALUSrcD),
    .ImmSrcD(ImmSrcD),
    .ALUOpD(ALUOpD),
    .PCPlus4D(PCPlus4D),
    .RD1D(RD1D),
    .RD2D(RD2D),
    .ImmExtD(ImmExtD),
    .Rs1D(RS1D),
    .Rs2D(RS2D),
    .RdD(RdD),
    .RegWriteE(RegWriteE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .ALUSrcE(ALUSrcE),
    .ImmSrcE(ImmSrcE),
    .ALUOpE(ALUOpE),
    .PCPlus4E(PCPlus4E),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .ImmExtE(ImmExtE),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .ALUControlD(ALUControlD),
    .ALUControlE(ALUControlE),
    .RdE(RdE)
);

// --- FORWARDING ---
wire [31:0] SrcAE, SrcBE_fwd;
wire [1:0] ForwardAE, ForwardBE;

minimux1 forwardA_mux (
    .ForwarAB(ForwardAE),
    .RD1E(RD1E),
    .Resultw(ResultW),
    .ALUResultM(ALUResultM),
    .SrcAE(SrcAE)
);

minimux2 forwardB_mux (
    .ForwarBE(ForwardBE),
    .RD2E(RD2E),
    .Resultw(ResultW),
    .ALUResultM(ALUResultM),
    .SrcBE(SrcBE_fwd)
);

// --- ALU SOURCE MUX ---
wire [31:0] SrcBE;
assign SrcBE = (ALUSrcE) ? ImmExtE : SrcBE_fwd;

// --- ALU ---
wire ZeroE, Flag2E;
alu alu_unit (
    .SrcAE(SrcAE),
    .SrcBE(SrcBE),
    .ALUControlD(ALUControlE),  // Corregido: ALUControlE
    .ALUResultE(ALUResultE),
    .ZeroE(ZeroE),
    .Flag2E(Flag2E)
);
// --- MUX ALU SOURCE B ---
wire [31:0] SrcBE_preMux;  // Salida del forwarding
wire [31:0] SrcBE_final;   // Salida del muxm

// Mux ALUSrc (selección entre registro e inmediato)
muxm alu_src_mux (
    .ImmExtE    (ImmExtE),
    .RE         (SrcBE_preMux),  // Registro después de forwarding
    .ALUSrcD    (ALUSrcE),       // ¡Importante! Usar ALUSrcE, no ALUSrcD
    .SrcBE      (SrcBE_final)
);

// Asignar a la ALU
assign SrcBE = SrcBE_final;

// --- PIPELINE EX/MEM ---
wire RegWriteM, MemWriteM;
wire [1:0] ResultSrcM;
wire [31:0] ALUResultM, RD2M, PCPlus4M;
wire [4:0] RdM;

EX_MEM ex_mem_reg (
    .CLK(CLK),
    .RegWriteE(RegWriteE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .ALUResultE(ALUResultE),
    .RD2E(RD2E),
    .PCPlus4E(PCPlus4E),
    .RdE(RdE),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM),
    .ALUResultM(ALUResultM),
    .RD2M(RD2M),
    .PCPlus4M(PCPlus4M),
    .RdM(RdM)
);

// --- DATA MEMORY ---
datamem #(
    .N(5),
    .M(32)
) data_memory (
    .CLK(CLK),
    .WE(MemWriteM),
    .A(ALUResultM[4:0]),
    .WD(RD2M),
    .RD(ReadDataM)
);

// --- PIPELINE MEM/WB ---

wire [1:0] ResultSrcW;
wire [31:0] ReadDataW, ALUResultW, PCPlus4W;


MEM_WB mem_wb_reg (
    .CLK(CLK),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .ReadDataM(ReadDataM),
    .ALUResultM(ALUResultM),
    .PCPlus4M(PCPlus4M),
    .RdM(RdM),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW),
    .ReadDataW(ReadDataW),
    .ALUResultW(ALUResultW),
    .PCPlus4W(PCPlus4W),
    .RdW(RdW)
);

// --- WRITE BACK MUX ---
mux4 wb_mux (
    .ResultSrcW(ResultSrcW),
    .ALUResultW(ALUResultW),
    .ReadDataW(ReadDataW),
    .PCPlus4W(PCPlus4W),
    .ImmExtW(ImmExtW),
    .ResultW(ResultW)
);
mux pc_next_mux (
    .PCPlus4F   (PCPlus4F),
    .PCTargetE  (PCTargetE),
    .PCSrcE     (PCSrcE),
    .PCF_next   (PCF_next)
);

// --- HAZARD UNIT ---
HazardUnit hazard_unit (
    .RS1D(RS1D),
    .RS2D(RS2D),
    .RS1E(Rs1E),
    .RS2E(Rs2E),
    .ResultSrcD(ResultSrcD),
    .RdE(RdE),
    .RdM(RdM),
    .RdW(RdW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .ResultSrcE(ResultSrcE),
    .PCWrite(PCWrite),
    .StallF(StallF),
    .StallD(StallD),
    .FlushD(FlushD),
    .FlushE(FlushE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
);

endmodule