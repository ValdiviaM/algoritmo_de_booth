`timescale 1ns/1ps
module tb_ss_entrada;

logic clk=0;
logic rst;

logic [3:0] A;
logic [3:0] B;
logic boton;

logic [3:0] _A;
logic [3:0] _B;
logic valid;

ss_entrada dut(
	 .clk(clk),
	 .rst(rst),	

	 .A(A),
	 .B(B),
	 .boton(boton),
	
	 .valid(valid),
	 ._A(_A),
	 ._B(_B)	
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
		boton=1;
		@(posedge clk)
		boton=0;
		#180;	
	end
	$finish;
	
end

endmodule
