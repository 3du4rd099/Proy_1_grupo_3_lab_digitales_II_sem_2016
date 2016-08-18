`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:03 08/17/2016 
// Design Name: 
// Module Name:    TestBenchSyncro 
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
module TestBenchSyncro(
		input wire clk, reset,
		input wire [2:0] sw,
		output wire hsync, vsync,
		output wire [2:0] rgb
    );
	 
	 //Declaracion para las senales
	 wire [9:0] pixel_x, pixel_y;
	 wire video_on, pixel_tick;
	 reg [2:0] rgb_reg;
	 wire [2:0] rgb_next;
	 
	 //intanciado del circuito vga
	 H_V_Sync_VGA_2 vsync_unit (.clk(clk), .reset(reset), .h_sync(hsync), .v_sync(vsync), .video_on(video_on), 
		.pixel_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));
	 
	 //Buffer del rgb
	 always @(posedge clk, posedge reset)
		if (reset)
			rgb_reg <= 0;
		else 
			rgb_reg <= sw;
		//Salida
		
		assign rgb = (video_on) ? rgb_reg : 3'b0;
endmodule
