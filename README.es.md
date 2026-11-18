# Procesador RISC-V en FPGA

[English](README.md) | Español

Procesador RISC-V de 32 bits escrito en Verilog, en dos microarquitecturas: monociclo y pipeline de 5 etapas. Desarrollado para el curso de Arquitectura de Computadores de la Universidad Industrial de Santander (UIS) y orientado a tarjetas Digilent Artix-7 (Basys 3 / Nexys 4 DDR).

## Diseños

| | Monociclo | Pipeline |
|---|---|---|
| Etapas | Búsqueda, decodificación, ejecución, memoria y escritura en un solo ciclo | IF, ID, EX, MEM, WB con registros de segmentación |
| Riesgos | No aplica | Adelantamiento de datos (EX/MEM y MEM/WB) y detención por load-use |
| Control de flujo | Salto y bifurcación resueltos en el mismo ciclo | Bifurcación resuelta en EX, con flush de IF/ID e ID/EX |

## Instrucciones soportadas

- **Tipo R:** `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`
- **Tipo I:** aritmética y lógica con inmediato, `lw`
- **Tipo S:** `sw`
- **Tipo B:** `beq`
- **Tipo U/J:** `lui`, `jal`

El decodificador del pipeline también cubre `jalr` y condiciones de bifurcación adicionales.

## Arquitectura

- Memoria de instrucciones: 16 palabras, construida con cuatro memorias de un byte e inicializada en el código fuente
- Memoria de datos: 32 palabras, escritura síncrona
- Banco de registros: 32 × 32 bits
- ALU con banderas de cero y comparación, controlada por un decodificador de dos niveles (decodificador principal y decodificador de ALU)

## Estructura del repositorio

```
single_cycle/   Fuentes en Verilog, testbench y restricciones
pipeline/       Fuentes en Verilog, unidad de riesgos y testbench
basys3_top/     Módulo superior para la tarjeta Basys 3
```

## Uso

**Simulación.** Abre el proyecto en Vivado (desarrollado con 2025.1), define el testbench como módulo superior de simulación (`tb_main` para monociclo, `tbmain` para pipeline) y ejecuta una simulación de comportamiento. Ambos generan un archivo de ondas `.vcd`.

**En la tarjeta.** En el módulo para Basys 3 (`conex`), `BTNC` funciona como reset y los 16 bits menos significativos del resultado de escritura se muestran en los LEDs. Sintetiza, implementa y programa el bitstream desde Vivado.

## Herramientas

Verilog · Vivado · Vivado Simulator (xsim) · Basys 3 (Artix-7 XC7A35T)

## Autor

Daniel Morelos — Ingeniería Electrónica, Universidad Industrial de Santander
