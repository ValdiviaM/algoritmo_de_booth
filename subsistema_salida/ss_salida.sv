module ss_salida (
	input logic clk,
	input logic rst,
	
	input logic [7:0] mult_in,
	input logic load,

	output logic [7:0] mult_out
);

always_ff @(posedge clk) begin
	if (rst) mult_out<=8'b0;
	else if (load) mult_out<=mult_in;
end

endmodule
