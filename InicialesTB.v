`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:14:29 08/18/2016
// Design Name:   Iniciales
// Module Name:   C:/Users/Carlos Gomez/Xilinx/SysGen/14.7/VGA_Controller/InicialesTB.v
// Project Name:  VGA_Controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Iniciales
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InicialesTB;

	// Inputs
	reg clk, Black, Blue, Green, Cyan, Red, Magenta, Yellow, White;
	reg [9:0] pix_x;
	reg [9:0] pix_y;
	reg [18:0] tiempo;
	reg [2:0] color;

	// Outputs
	wire [3:0] text_on;
	wire [2:0] text_rgb;
	wire hsync, vsync;
	
	// Instantiate the Unit Under Test (UUT)
	Iniciales uut (
		.clk(clk),
		.Black(Black),
		.Blue(Blue),
		.Green(Green),
		.Cyan(Cyan),
		.Red(Red),
		.Magenta(Magenta),
		.Yellow(Yellow),
		.White(White),
		.pix_x(pix_x), 
		.pix_y(pix_y), 
		.text_on(text_on), 
		.text_rgb(text_rgb)
	);


	initial begin
		// Initialize Inputs
		clk = 0;
		pix_x = 0;
		pix_y = 0;
		Black = 0;
		Blue = 0;
		Green = 0;
		Cyan = 0;
		Red = 0;
		Magenta = 0;
		Yellow = 0;
		White = 0;
		tiempo = 0;
		color = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always begin
	#20 clk =! clk;
	end
	always @(posedge clk) 
      if (pix_x==800)begin
         pix_x <=0; pix_y <= pix_y + 1;
      end else if(pix_y==525) begin
         pix_y <= 0;
			end
		else begin
			pix_x <= pix_x + 1;
		end
	always @(posedge clk) 
      if (tiempo==420000)begin
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


