define_design_lib WORK -path ./work
set search_path [list . /software/synopsys/syn_current_64.18/libraries/syn /software/dk/nangate45/synopsys ]
set link_library [list "*" "NangateOpenCellLibrary_typical_ecsm_nowlm.db" "dw_foundation.sldb" ]
set target_library [list "NangateOpenCellLibrary_typical_ecsm_nowlm.db" ]
set synthetic_library [list "dw_foundation.sldb" ]
analyze -f vhdl -lib WORK ../src/myfilter.vhd
set power_preserve_rtl_hier_names true
elaborate myfilter -arch beh -lib WORK > ./elaborate.txt
create_clock -name MY_CLK -period 5  CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_dont_touch_network MY_CLK
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_input] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile > compile.txt
report_timing > report_timing.txt
report_area > report_area.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/myfilter.sdf
write -f verilog -hierarchy -output ../netlist/myfilter.v
write_sdc ../netlist/myfilter.sdc

