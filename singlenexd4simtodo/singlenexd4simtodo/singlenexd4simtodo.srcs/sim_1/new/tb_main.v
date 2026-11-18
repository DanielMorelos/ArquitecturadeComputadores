
module tb_main;

  // Entradas
  reg CLK;

  // Salidas observables del UUT
  wire [31:0] debug_result;
reg RST;

main uut (
    .CLK(CLK),
    .RST(RST),
    .debug_result(debug_result)
);

initial begin
    RST = 1;
    #20;
    RST = 0;
end
  // Generador de reloj: periodo de 10 ns (100 MHz)
  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
  end

  // Configuración de simulación: generar archivo VCD
  initial begin
    $dumpfile("resultados_main.vcd");
    $dumpvars(0, tb_main);
  end

  // Casos de prueba
  initial begin
    #200;
    $finish;
  end

endmodule