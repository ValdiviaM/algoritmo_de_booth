vlog -sv contador.sv
vlog -sv datapath.sv
vlog -sv fsm_mult.sv
vlog -sv ss_mult.sv
vlog -sv ss_mult_tb.sv

vsim -voptargs=+acc -t ns -onfinish stop ss_mult_tb

add wave *

run -all

