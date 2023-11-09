module ss_mult #(
	parameter N=4
)(
	input logic clk,
	input logic rst,
	//entradas del sistema de lectura
	input logic valid,
	input logic [N-1:0] A,
	input logic [N-1:0] B,
	//salidas para el sistema de resultados
	output logic done,
	output logic [7:0] result

);	
//para conexion entre modulos
logic [1:0] Q_LSB;
logic count_done;
logic load_A;
logic load_B;
logic load_add;
logic ar_shift;
logic add_sub;
logic count;
logic start;

fsm_multi main_fsm(
	.clk(clk),
	.rst(rst),
	.count_done(count_done),
	.valid(valid),
	.Q_LSB(Q_LSB),
	
	.load_A(load_A),
	.load_B(load_B),
	.load_add(load_add),
	.ar_shift(ar_shift),
	.add_sub(add_sub),
	.count(count),
	.start(start),
	.done(done)
);

counter counter(
	.rst(start),
	.clk(clk),
	.count(count),
	
	.count_done(count_done)
);

datapath datapath(
	.clk(clk),
	.rst(rst),
	.A(A),
	.B(B),
	.load_A (load_A),
	.load_B	(load_B),
	.load_add(load_add),	
	.ar_shift(ar_shift), 
	.add_sub(add_sub),
	.start(start),

	.Q_LSB(Q_LSB),
	.result(result)
);

endmodule
