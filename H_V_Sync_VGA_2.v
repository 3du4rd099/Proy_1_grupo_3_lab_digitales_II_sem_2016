`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:45 08/17/2016 
// Design Name: 
// Module Name:    H_V_Sync_VGA_2 
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
module H_V_Sync_VGA_2(
	input wire clk,reset, //señal de reloj de la FPGA y un reset asincrónico para el sistema
	output wire h_sync, v_sync, video_on, pixel_tick,	 //señales de monitoreo, sincronización y control
	output wire [9:0] pixel_x, pixel_y //señales que permiten ubicar la posición del pixel_x y pixel_y
	);

//declarando parámetros
	//Modo VGA 640x480 se considera el uso de los parametros debido a los tiempos de retraso de las compuertas y del monitor mismo
	localparam Hor_Disp = 640; //Area de dibujo horizontal 
	localparam Hor_Bor_Izq = 48; //Area horizontal de borde negro izquierdo
	localparam Hor_Bor_Der = 16; //Area horizaontal de borde negro derecho
	localparam Hor_Ret = 96; //Retraso horizontal debido a reposicion del monitor
	localparam Ver_Disp = 480; //Area de display vertical
	localparam Ver_Bor_Sup = 10; //Area vertical de borde negro superior
	localparam Ver_Bor_Inf = 33; //Area vertical de borde negro inferior
	localparam Ver_Ret = 2; //Retraso vertical
	
	// Circuito Divisor de frecuencia
	reg [2:0]counter; //Registro Para Contar
	wire clk_out; //Salida que produce el contador
	
	//Sincronizadores
	reg [9:0] hor_cont_reg, hor_cont_next;
	reg [9:0] ver_cont_reg, ver_cont_next;
	
	//Buffer de salida para evitar desincronizaciones
	reg ver_sinc_reg, hor_sinc_reg;
	wire ver_sinc_next, hor_sinc_next;
	
	//Pulsos de control
	wire hor_end, ver_end, pixel_tic_mod;
	
	//Cuerpo del modulo con los registros
	always @ (posedge clk, posedge reset)
	if (reset)
		begin
			counter <= 1'b0;
			ver_cont_reg <= 0;
			hor_cont_reg <= 0;
			ver_sinc_reg <= 1'b0;
			hor_sinc_reg <= 1'b0;
		end
	else
		begin
			counter <= clk_out;
			ver_cont_reg <= ver_cont_next;
			hor_cont_reg <= hor_cont_next;
			ver_sinc_reg <= ver_sinc_next;
			hor_sinc_reg <= hor_sinc_next;
		end
//generador de 25MHZ
initial begin //asignación de valores iniciales
    counter = 0;
    clk_out = 0;
end
always @(posedge clk_in) begin //en cada cambio posiivo genera un coportamiento de flop flop
    if (counter == 0) begin
        counter <= 4; //contador que alcanza 4194304 para asignar una salida a aproximadamente 10Hz
        clk_out <= ~clk_out; //cuando el contador alcanza 4194304 el relog asigna al clk_out una salida en alto
    end else begin
        counter <= counter -1; //si las condiciones no se contemplan el contador comienza a reducirse hasta que alcanze 4194304
    end
end
assign pixel_tick = clk_out;
 
//Pulsos de estado
//asignando el contador horizontal
assign hor_end = (hor_cont_reg == (Hor_Disp+Hor_Bor_Izq+Hor_Bor_Der+Hor_Ret));
//asignando el contador vertical
assign ver_end = (ver_cont_reg == (Ver_Disp+Ver_Bor_Sup+Ver_Bor_Inf+Ver_Ret));

//logica del siguiente estado horizontal
always @*
	if (clk_out)
		if (hor_end)
			hor_cont_next = 0;
		else 
			hor_cont_next = hor_cont_reg + 1;
	else
		hor_cont_next = hor_cont_reg;
		
//logica del sigueinte estado vertical
always @*
	if (clk_out & hor_end)
		if (ver_end)
			ver_cont_next = 0;
		else 
			ver_cont_next = ver_cont_reg + 1;
	else
		ver_cont_next = ver_cont_reg;
		
//sincronizacion vertical y horizontal con buffer para evitar datos errados

//h_sync sincronizacion horizontal
assign hor_sinc_next = (hor_cont_reg >= (Hor_Disp+Hor_Bor_Der) && hor_cont_reg <= (Hor_Disp+Hor_Bor_Der+Hor_Ret-1));

//v_syncsincronizacion vertical
assign ver_sinc_next = (ver_cont_reg >= (Ver_Disp+Ver_Bor_Inf) && hor_cont_reg <= (Ver_Disp+Ver_Bor_Inf+Ver_Ret-1));

//puslo de control de video para encender el proceso de coloracion
assign video_on = (hor_cont_reg < Hor_Disp) && (ver_sinc_next < Ver_Disp);

//salidas
assign h_sync = hor_sinc_reg;
assign v_sync = ver_sinc_reg;
assign pixel_x = hor_cont_reg;
assign pixel_y = ver_cont_reg;
assign pixel_tick = pixel_tic_mod;

endmodule
