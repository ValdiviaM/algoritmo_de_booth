module sistema (
	input logic clk,
	input logic rst,
	//sistema lectura
	input logic [3:0] A,
	input logic [3:0] B,
	input logic boton,
	//salida display
	output logic [7:0] display
);
//conexion entre sistema de lectura y multiplicacion
logic valid;
logic [3:0] A_sinc;
logic [3:0] B_sinc;

//conexion entre sistema de multiplicacion y de salida
logic done;
logic [7:0] result;

ss_entrada ss_entrada (
	.clk(clk),
	.rst(rst),	
	//entradas del sistema
	.A(A),
	.B(B),
	.boton(boton),
	//salidas para el subsistema que multiplica
	.valid(valid),
	._A(A_sinc),
	._B(B_sinc)
);

ss_mult multiplicador(
	.clk(clk),
	.rst(rst),
	//entradas del sistema de lectura
	.valid(valid),
	.A(A_sinc),
	.B(B_sinc),
	//salidas para el sistema de resultados
	.done(done),
	.result(result)
);

ss_salida salida(
	.clk(clk),
	.rst(rst),
	//entrada del sistema de multiplicacion
	.result(result),
	.load(done),
	//salida del sistema
	.display(display)
);

endmodule
