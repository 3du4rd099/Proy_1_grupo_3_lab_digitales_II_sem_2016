`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:46:03 08/18/2016
// Design Name:   vga_sync
// Module Name:   C:/Users/Carlos Gomez/Xilinx/SysGen/14.7/VGA_Controller/vga_syncTB.v
// Project Name:  VGA_Controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_sync
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_syncTB;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#500 reset = 0;

		// Wait 100 ns for global reset to finish        
		// Add stimulus here
	end
		always begin
	#10 clk =! clk;
	end

       
endmodule

