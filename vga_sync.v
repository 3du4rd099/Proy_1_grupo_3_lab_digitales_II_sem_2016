`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:35:05 08/18/2016 
// Design Name: 
// Module Name:    vga_sync 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_sync(
   input wire clk,reset, //señal de reloj de la FPGA y un reset asincrónico para el sistema
	output wire hsync, vsync, video_on, p_tick,	 //señales de monitoreo, sincronización y control
	output wire [9:0] pixel_x, pixel_y //señales que permiten ubicar la posición del pixel_x y pixel_y
	);

	//declarando parámetros
	//Modo VGA 640x480 se considera el uso de los parametros debido a los tiempos de retraso de las compuertas y del monitor mismo
	localparam HD = 640; //Area de dibujo horizontal 
	localparam HF = 48; //Area horizontal de borde negro izquierdo
	localparam HB = 16; //Area horizaontal de borde negro derecho
	localparam HR = 96; //Retraso horizontal debido a reposicion del monitor
	localparam VD = 480; //Area de display vertical
	localparam VF = 10; //Area vertical de borde negro superior
	localparam VB = 33; //Area vertical de borde negro inferior
	localparam VR = 2; //Retraso vertical
	
	// Circuito Divisor de frecuencia
	reg mod2_reg; //Registro Para Contar
	wire mod2_next; //Salida que produce el contador
	
	//Sincronizadores
	reg [9:0] h_count_reg, h_count_next;
	reg [9:0] v_count_reg, v_count_next;
	
	//Buffer de salida para evitar desincronizaciones
	reg v_sync_reg, h_sync_reg;
	wire v_sync_next, h_sync_next;
	
	//Pulsos de control
	wire h_end, v_end, pixel_tick;
	
	//Cuerpo del modulo con los registros
	always @ (posedge clk, posedge reset)
	if (reset)
		begin
			mod2_reg <= 1'b0;
			v_count_reg <= 0;
			h_count_reg <= 0;
			v_sync_reg <= 1'b0;
			h_sync_reg <= 1'b0;
		end
	else
		begin
			mod2_reg <= mod2_next;
			v_count_reg <= v_count_next;
			h_count_reg <= h_count_next;
			v_sync_reg <= v_sync_next;
			h_sync_reg <= h_sync_next;
		end
	//generador de 25MHZ
	assign mod2_next = ~mod2_reg;
	assign pixel_tick = mod2_reg;
 
	//Pulsos de estado
	//asignando el contador horizontal
	assign h_end = (h_count_reg == (HD+HF+HB+HR-1));
	//asignando el contador vertical
	assign v_end = (v_count_reg == (VD+VF+VB+VR-1));

	//logica del siguiente estado horizontal
	always @*
		if (pixel_tick)
			if (h_end)
				h_count_next = 0;
			else 
				h_count_next = h_count_reg + 1;
		else
			h_count_next = h_count_reg;
		
	//logica del sigueinte estado vertical
	always @*
		if (pixel_tick & h_end)
			if (v_end)
				v_count_next = 0;
			else 
				v_count_next = v_count_reg + 1;
		else
			v_count_next = v_count_reg;
		
	//sincronizacion vertical y horizontal con buffer para evitar datos errados

	//h_sync sincronizacion horizontal
	assign h_sync_next = (h_count_reg >= (HD+HB) && h_count_reg <= (HD+HB+HR-1));

	//v_syncsincronizacion vertical
	assign v_sync_next = (v_count_reg >= (VD+VB) && v_count_reg <= (VD+VB+VR-1));

	//puslo de control de video para encender el proceso de coloracion
	assign video_on = (h_count_reg < HD) && (v_count_reg < VD);

	//salidas
	assign hsync = h_sync_reg;
	assign vsync = v_sync_reg;
	assign pixel_x = h_count_reg;
	assign pixel_y = v_count_reg;
	assign p_tick = pixel_tick;

endmodule
