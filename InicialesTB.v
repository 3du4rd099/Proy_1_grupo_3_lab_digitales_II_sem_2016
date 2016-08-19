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
	reg clk;
	reg [9:0] pix_x;
	reg [9:0] pix_y;

	// Outputs
	wire [3:0] text_on;
	wire [2:0] text_rgb;
	
	// Instantiate the Unit Under Test (UUT)
	Iniciales uut (
		.clk(clk), 
		.pix_x(pix_x), 
		.pix_y(pix_y), 
		.text_on(text_on), 
		.text_rgb(text_rgb)
	);
	reg hmax;
	initial begin
		// Initialize Inputs
		clk = 0;
		pix_x = 0;
		pix_y = 0;
		hmax = 0;

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
endmodule

