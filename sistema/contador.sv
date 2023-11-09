module counter #(
	parameter N=4
)(
	input logic rst,
	input logic clk,
	input logic count,
	output logic count_done
);

logic [2:0] count_reg;
//cuenta de N hasta 0
always_ff @(posedge clk) begin
	if (rst) begin
		count_reg<=N;
		count_done<=0;		
	end else if (count&&(count_reg!=0)) begin
		count_reg<=count_reg-1;
		count_done<=0;
	end	else if (count&&(count_reg==0)) begin
		count_done<=1;
	end
end
endmodule
