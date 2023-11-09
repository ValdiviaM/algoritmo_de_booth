module fsm_multi (
	input logic clk,
	input logic rst,
	//entrada del contador
	input logic count_done,
	//entrada del sistema de lectura
	input logic valid,
	//entrada del multiplicador
	input logic [1:0] Q_LSB,
	//salidas para el datapath
	output logic load_A,
	output logic load_add,
	output logic load_B,
	output logic ar_shift,
	output logic add_sub,
	//salidas para el contador
	output logic count,
	output logic start,
	//salida para el sistema de resultado
	output logic done
);

typedef enum logic [2:0] {
    ESPERA_INICIO,
	INICIO,
    COMPARA,
    SUMAR,
	RESTAR,
	DESPLAZA
} estado_t;
  
estado_t estado, sig_estado;

always_ff @(posedge clk) begin
	if (rst) estado<=ESPERA_INICIO; 	
	else 	 estado<=sig_estado;
end

//logica de siguiente estado

always_comb begin
	case(estado)
		ESPERA_INICIO: begin
			if(valid) sig_estado=INICIO;
			else 	  sig_estado=ESPERA_INICIO;
			end
		INICIO:
			sig_estado=COMPARA;
		COMPARA: begin
			case (Q_LSB)
				2'b01: sig_estado=SUMAR;
				2'b10: sig_estado=RESTAR;
				default:
					sig_estado=DESPLAZA;
			endcase
			end
		SUMAR: begin
				if (count_done) sig_estado=ESPERA_INICIO;
				else sig_estado = COMPARA;		
			end
		RESTAR: begin
			   	 if (count_done) sig_estado=ESPERA_INICIO;
				 else sig_estado = COMPARA;		
			end
		DESPLAZA:begin
				if (count_done) sig_estado=ESPERA_INICIO;
				else sig_estado = COMPARA;		
			end
		default:
			sig_estado=ESPERA_INICIO;
	endcase
end

//logica de salida -MEALY

always_comb begin
	load_A = 0;
	load_add = 0;
	load_B = 0;
	ar_shift = 0;
	add_sub = 0;
	count = 0;
	start = 0;
	done = 0;
	case(estado)
		ESPERA_INICIO: 
			if (valid) start = 1; 		

		INICIO: begin
				load_A = 1;
				load_B = 1;
				end
		COMPARA: begin
			count=1;	
			case (Q_LSB)
				2'b01: begin
					add_sub=1;
					load_add=1;
					end
				2'b10: 
					load_add=1;
				default:
					ar_shift=1;
			endcase
			end
		SUMAR: begin 
			add_sub=1;
			if(count_done) done=1;
			else ar_shift=1;	
			end	
		RESTAR: begin 
			if(count_done) done=1;
			else ar_shift=1;	
			end	
		DESPLAZA:
			if(count_done) done=1;
	endcase
end

endmodule

