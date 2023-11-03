vlog -sv sincronizador.sv
vlog -sv convertidor_pulso.sv
vlog -sv ss_entrada.sv
vlog -sv tb_ss_entrada.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_ss_entrada

add wave *

run -all
