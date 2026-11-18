//Main Decoder
module maindecoder (
    input  [6:0] op,            // opcode
    output reg Branch,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0] ResultSrc,
    output reg ALUSrc,
    output reg [2:0] ImmSrc,
    output reg [1:0] ALUOp
);
    always @(*) begin

        // Valores por defecto (seguro)
        Branch     = 0;
        RegWrite   = 0;
        MemWrite   = 0;
        ResultSrc  = 2'b00;
        ALUSrc     = 0;
        ImmSrc     = 3'b000;
        ALUOp      = 2'b00;
        case (op)
            // R-TYPE: ADD, SUB, AND, OR, XOR, SLT, SLL, SRL, SRA
            7'b0110011: begin
                RegWrite  = 1;
                ALUSrc    = 0;
                ResultSrc = 2'b00;
                ALUOp     = 2'b10;      // usar funct3/funct7
            end
            // I-TYPE ALU: ADDI, ANDI, ORI, SLTI, SLLI, SRLI, SRAI
            7'b0010011: begin
                RegWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b000;     // tipo I
                ResultSrc = 2'b00;
                ALUOp     = 2'b10;      // igual que R, usa funct3
            end

            // LOAD (LW)
            7'b0000011: begin
                RegWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b000;     // tipo I
                ResultSrc = 2'b01;      // dato desde memoria
                ALUOp     = 2'b00;      // suma base + offset
            end

            // STORE (SW)
            7'b0100011: begin
                RegWrite  = 0;
                MemWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b001;     // tipo S
                ALUOp     = 2'b00;      // suma base + offset
            end

            // BRANCH (BEQ, BNE, BLT, BGE)
            7'b1100011: begin
                Branch    = 1;
                ALUSrc    = 0;
                ImmSrc    = 3'b010;     // tipo B
                ALUOp     = 2'b01;      // comparaciones (SUB/SLT)
            end
            // JAL
            7'b1101111: begin
                RegWrite  = 1;
                ALUSrc    = 1;          // PC + inmediato
                ImmSrc    = 3'b101;     // tipo J
                ResultSrc = 2'b10;      // PC+4 a RD
                // ALUOp = 00  (suma simple para PC)
            end
            // JALR
            7'b1100111: begin
                RegWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b000;     // tipo I
                ResultSrc = 2'b10;      // PC+4
                // ALUOp = 00
            end
            // LUI
            7'b0110111: begin
                RegWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 3'b100;     // tipo U
                ResultSrc = 2'b11;      // inmediato directo a RD
            end
            default: begin
            end
        endcase
    end

endmodule