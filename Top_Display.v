`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:31:40 08/19/2016 
// Design Name: 
// Module Name:    Top_Display 
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
module Top_Display(
    input wire clk,reset, //señal de reloj de la FPGA y un reset asincrónico para el sistema
	 input wire Black, Blue, Green, Cyan, Red, Magenta, Yellow, White, //colores a escoger por el usuasrio
	 output wire text_on,
    output wire [2:0] text_rgb
	 );
	 
	 wire hsync, vsync;
	 wire [9:0] pixel_x, pixel_y;
	 wire p_tick;
	 
	vga_sync sincronizador_vga (.clk(clk), .reset(reset), .hsync(), .vsync(), .video_on(), .p_tick(p_tick),
		.pixel_x(pixel_x), .pixel_y(pixel_y));
	Iniciales generador_pixel (.clk(p_tick), .pix_x(pixel_x), .pix_y(pixel_y), .Black(Black), .Blue(Blue), .Green(Green),
	.Cyan(Cyan), .Red(Red), .Magenta(Magenta), .Yellow(Yellow), .White(White), .text_on(text_on), .text_rgb(text_rgb));


endmodule
