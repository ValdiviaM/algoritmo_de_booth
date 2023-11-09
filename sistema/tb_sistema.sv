`timescale 1ns/1ps
module tb_sistema;

logic clk=0;
logic rst;

logic [3:0] A;
logic [3:0] B;
logic boton;
logic [7:0] display;

sistema dut (
	.clk(clk),
	.rst(rst),

	.A(A),
	.B(B),
	.boton(boton),

	.display(display)
);

initial forever #5 clk=~clk;

initial begin
	A=0;
	B=0;
	boton=0;
	rst=0;
	@(posedge clk)
	rst=1;
	@(posedge clk)
	rst=0;
	repeat(50) begin
		A=$random;
		B=$random;
		@(posedge clk)
		@(posedge clk)
		@(posedge clk)
		boton=$random;
		@(posedge clk)
		boton=$random;
		#180;	
	end
	$finish;
end
endmodule
