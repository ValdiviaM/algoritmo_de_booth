module sincronizador(

input logic rst,
input logic clk,
input logic [3:0] In,
output logic [3:0] Out 

);

logic aux00;
logic aux01;
logic aux02;
logic aux03;

logic aux10;
logic aux11;
logic aux12;
logic aux13;

logic aux20;
logic aux21;
logic aux22;
logic aux23;


always_ff @(posedge clk) begin
	//sincroniza bit 0
	if (rst) begin 
		aux00<=1'b0;
		aux10<=1'b0;
		aux20<=1'b0;
		Out[0]<=1'b0;		
	end	
	else begin
		aux00<=In[0];
		aux10<=aux00;
		aux20<=aux10;	
		Out[0]<=aux20;
	end
end
	//sincroniza bit 1
always_ff @(posedge clk) begin
	if (rst) begin 
		aux01<=1'b0;
		aux11<=1'b0;
		aux21<=1'b0;
		Out[1]<=1'b0;		
	end	
	else begin

		aux01<=In[1];
		aux11<=aux01;
		aux21<=aux11;	
		Out[1]<=aux21;
	end
end
	//sincroniza bit 2

always_ff @(posedge clk) begin
	if (rst) begin 
		aux02<=1'b0;
		aux12<=1'b0;
		aux22<=1'b0;
		Out[2]<=1'b0;		
	end	
	else begin
		aux02<=In[2];
		aux12<=aux02;
		aux22<=aux12;	
		Out[2]<=aux22;
	end
end
	//sincroniza bit 3
always_ff @(posedge clk) begin
	if (rst) begin 
		aux03<=1'b0;
		aux13<=1'b0;
		aux23<=1'b0;
		Out[3]<=1'b0;		
	end	
	else begin
		aux03<=In[3];
		aux13<=aux03;
		aux23<=aux13;	
		Out[3]<=aux23;
	end
end

endmodule
