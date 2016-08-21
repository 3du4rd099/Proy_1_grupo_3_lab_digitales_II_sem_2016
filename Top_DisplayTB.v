`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:31:52 08/22/2016
// Design Name:   Top_Display
// Module Name:   C:/Users/Carlos Gomez/Xilinx/SysGen/14.7/VGA_Controller/Top_DisplayTB2.v
// Project Name:  VGA_Controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Top_DisplayTB2;

	// Inputs
	reg clk;
	reg reset;
	reg Black;
	reg Blue;
	reg Green;
	reg Cyan;
	reg Red;
	reg Magenta;
	reg Yellow;
	reg White;
	reg color;
	reg tiempo;

	// Outputs
	wire text_on;
	wire video_on;
	wire hsync;
	wire vsync;
	wire [2:0] text_rgb;

	// Instantiate the Unit Under Test (UUT)
	Top_Display uut (
		.clk(clk), 
		.reset(reset), 
		.Black(Black), 
		.Blue(Blue), 
		.Green(Green), 
		.Cyan(Cyan), 
		.Red(Red), 
		.Magenta(Magenta), 
		.Yellow(Yellow), 
		.White(White), 
		.text_on(text_on), 
		.video_on(video_on), 
		.hsync(hsync), 
		.vsync(vsync), 
		.text_rgb(text_rgb)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		Black = 0;
		Blue = 0;
		Green = 0;
		Cyan = 0;
		Red = 0;
		Magenta = 0;
		Yellow = 0;
		White = 0;
		color = 0;
		tiempo = 0;

		// Wait 100 ns for global reset to finish
		#100 reset=0;
        
		// Add stimulus here

	end
      always begin
	#10 clk =! clk;
	end
	always @(posedge clk) 
      if (tiempo==840000)begin
         tiempo <=0; color <= color + 1;
      end else if (color == 8) begin
         color = 0;
			end
			else begin
			tiempo <= tiempo + 1;
			end
	always @(posedge clk)
	case (color)
      3'b000 : begin
                  Black= 1;
						Blue = 0;
						Green = 0;
						Cyan = 0;
						Red = 0;
						Magenta = 0;
						Yellow = 0;
						White = 0;
               end
      3'b001 : begin
                  Black= 0;
						Blue = 1;
						Green = 0;
						Cyan = 0;
						Red = 0;
						Magenta = 0;
						Yellow = 0;
						White = 0;
               end
      3'b010 : begin
                  Black= 0;
						Blue = 0;
						Green = 1;
						Cyan = 0;
						Red = 0;
						Magenta = 0;
						Yellow = 0;
						White = 0;
               end
      3'b011 : begin
                  Black= 0;
						Blue = 0;
						Green = 0;
						Cyan = 1;
						Red = 0;
						Magenta = 0;
						Yellow = 0;
						White = 0;
               end
      3'b100 : begin
                  Black= 0;
						Blue = 0;
						Green = 0;
						Cyan = 0;
						Red = 1;
						Magenta = 0;
						Yellow = 0;
						White = 0;
               end
      3'b101 : begin
                  Black= 0;
						Blue = 0;
						Green = 0;
						Cyan = 0;
						Red = 0;
						Magenta = 1;
						Yellow = 0;
						White = 0;
               end
      3'b110 : begin
                  Black= 0;
						Blue = 0;
						Green = 0;
						Cyan = 0;
						Red = 0;
						Magenta = 0;
						Yellow = 1;
						White = 0;
               end
      3'b111 : begin
                  Black= 0;
						Blue = 0;
						Green = 0;
						Cyan = 0;
						Red = 0;
						Magenta = 0;
						Yellow = 0;
						White = 1;
               end
      default: begin
                  Black=1;
               end
   endcase
	
	
      
endmodule

	
	
      
endmodule

