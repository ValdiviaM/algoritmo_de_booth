vlog -sv sincronizador.sv
vlog -sv convertidor_pulso.sv
vlog -sv ss_entrada.sv
vlog -sv fsm_mult.sv
vlog -sv contador.sv
vlog -sv datapath.sv
vlog -sv ss_mult.sv
vlog -sv ss_salida.sv
vlog -sv sistema.sv
vlog -sv tb_sistema.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_sistema

add wave *

run -all
