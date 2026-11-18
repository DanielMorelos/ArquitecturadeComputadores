create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports CLK]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property DONT_TOUCH true [get_cells alu]
set_property DONT_TOUCH true [get_cells mem_principal]
set_property DONT_TOUCH true [get_cells PCplus]
set_property DONT_TOUCH true [get_cells PCtarget]
set_property DONT_TOUCH true [get_cells regfile]
set_property DONT_TOUCH true [get_cells regparalelo2]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports CLK]

create_pblock pblock_1
add_cells_to_pblock [get_pblocks pblock_1] [get_cells -quiet [list PCplus PCtarget alu datamem mem_principal regfile regparalelo2]]
resize_pblock [get_pblocks pblock_1] -add {SLICE_X2Y55:SLICE_X9Y69}
resize_pblock [get_pblocks pblock_1] -add {RAMB18_X0Y22:RAMB18_X0Y27}
resize_pblock [get_pblocks pblock_1] -add {RAMB36_X0Y11:RAMB36_X0Y13}
set_property IS_SOFT FALSE [get_pblocks pblock_1]
