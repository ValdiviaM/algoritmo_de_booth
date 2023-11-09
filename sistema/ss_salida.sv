module ss_salida (
	input logic clk,
	input logic rst,
	
	input logic [7:0] result,
	input logic load,

	output logic [7:0] display
);

always_ff @(posedge clk) begin
	if (rst) display<=8'b0;
	else if (load) display<=result;
end

endmodule
