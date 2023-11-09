module convertidor_pulso(
	input logic clk,
	input logic rst,	

	input logic in,
	output logic out
);

enum logic {
  	ESPERA_PRESS,
    ESPERA_REL } estado, sig_estado;

always_ff @(posedge clk) begin
	if (rst) estado <= ESPERA_PRESS;
	else estado <= sig_estado;
end

//logica de siguiente estado
always_comb begin
	case(estado)
		ESPERA_PRESS:
			if (in) sig_estado = ESPERA_REL;
			else	sig_estado = ESPERA_PRESS;
		ESPERA_REL:
			if (in) sig_estado = ESPERA_REL;
			else	sig_estado = ESPERA_PRESS;		
		default:
			sig_estado = ESPERA_PRESS;
	endcase
end

//logica de salida -MEALY
assign out= estado & (~in);

endmodule
