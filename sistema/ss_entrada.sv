module ss_entrada(
	input logic clk,
	input logic rst,	

	input logic [3:0] A,
	input logic [3:0] B,
	input logic boton,
	
	output logic valid,
	output logic [3:0] _A,
	output logic [3:0] _B	
);

sincronizador sincA (
	.rst(rst),
	.clk(clk),
	.In(A),
	.Out(_A) 
);

sincronizador sincB (
	.rst(rst),
	.clk(clk),
	.In(B),
	.Out(_B) 
);

convertidor_pulso nivel_pulso(
	.clk(clk),
	.rst(rst),	

	.in(boton),
	.out(valid)
);
endmodule
