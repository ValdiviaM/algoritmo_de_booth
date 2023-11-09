vlog -sv ss_salida.sv
vlog -sv tb_ss_salida.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_ss_salida
add wave *

run -all
