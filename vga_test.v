`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:47 08/18/2016 
// Design Name: 
// Module Name:    vga_test 
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
module vga_test(input wire clk, reset,
		input wire [2:0] sw,
		output wire hsync, vsync,
		output wire [2:0] rgb
    );
	 
	 //Declaracion para las senales
	 reg [2:0] rgb_reg;
	 wire video_on;
	 
	 //intanciado del circuito vga
	 vga_sync vsync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), 
		.p_tick(), .pixel_x(), .pixel_y());
	 
	 //Buffer del rgb
	 always @(posedge clk, posedge reset)
		if (reset)
			rgb_reg <= 0;
		else 
			rgb_reg <= sw;
			
		//Salida
		assign rgb = (video_on) ? rgb_reg : 3'b0;
endmodule
