module datapath #(
	parameter N = 4
)(
	input logic clk,
	input logic rst,

	input logic [N-1:0] A,
	input logic [N-1:0] B,
	input logic load_A,
	input logic load_B,
	input logic load_add,
	input logic ar_shift,
	input logic add_sub,
	input logic start,
	output logic [1:0] Q_LSB,
	output logic [7:0] result
);	
	logic [2*N:0] shift_reg;
	logic [N-1:0] M;
	logic [N-1:0] adder_sub_out;
	logic [3:0] HQ;
	logic [3:0] LQ;
	logic Q_1;

//reg_M
always_ff @(posedge clk) begin
	if (rst) M<=4'b0;
	else if (load_A) M<=A;
end

// adder / sub
always_comb begin
	if (add_sub)
		adder_sub_out = HQ+M;
	else
		adder_sub_out = HQ-M;
end

// shift registers
always_comb begin
	result = {HQ,LQ};
	HQ = shift_reg [8:5];
	LQ = shift_reg [4:1] ;
	Q_1 = shift_reg [0] ;
	Q_LSB = {LQ[0] ,Q_1} ;
end

always_ff @(posedge clk) begin	
	if (start||rst) shift_reg<=9'b0;
	else if (ar_shift)
	// arithmetic shift
		shift_reg <= $signed(shift_reg)>>>1;
	else begin
		if (load_B)
			shift_reg[N:1] <= B;
		if (load_add)
			shift_reg[2*N:N+1] <= adder_sub_out;
	end
end

endmodule 

