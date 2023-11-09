`timescale 1ns/1ps
module tb_ss_salida;

logic clk=0;
logic rst;
logic [7:0] mult_in;
logic [7:0] mult_out;
logic load;

ss_salida dut(
	.clk(clk),
	.rst(rst),
	.mult_in(mult_in),
	.mult_out(mult_out),
	.load(load)
);

initial forever #5 clk=~clk;

initial begin
	rst=0;
	mult_in=0;
	load=0;
	#10
	rst=1;
	#10
	rst=0;
	repeat(50) begin
		mult_in=$random;
		@(posedge clk)
		@(posedge clk)
		load=$random;
		@(posedge clk)		
		@(posedge clk)
		load=$random;
		#180;	
	end
	$finish;
end

endmodule
