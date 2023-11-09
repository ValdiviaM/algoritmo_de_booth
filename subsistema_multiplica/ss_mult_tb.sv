`timescale 1ns/1ps
module ss_mult_tb;

logic clk=0;
logic rst;

logic [3:0] A;
logic [3:0] B;
logic valid;

logic done;
logic [7:0] result;

ss_mult dut(
	 .clk(clk),
	 .rst(rst),	
	 .A(A),
	 .B(B),
	 .valid(valid),

	 .done(done),
	 .result(result)	
);

initial forever #5 clk=~clk;	//frecuencia 100MHz

initial begin
	rst=0;
	A=0;
	B=0;
	valid=0;
	@(posedge clk)
	rst=1;
	@(posedge clk)
	rst=0;
	repeat(50) begin
		A=$random;
		B=$random;
		@(posedge clk)
		@(posedge clk)
		rst=0;
		@(posedge clk)
		valid=1;
		@(posedge clk)
		valid=0;
		#180	
		$display("%b x %b = %b", A, B, result);
	end
	$finish;
end
endmodule

