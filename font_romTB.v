`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:28:51 08/18/2016
// Design Name:   font_ROM
// Module Name:   C:/Users/Carlos Gomez/Xilinx/SysGen/14.7/VGA_Controller/font_romTB.v
// Project Name:  VGA_Controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: font_ROM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module font_romTB;

	// Inputs
	reg clk;
	reg [10:0] addr;

	// Outputs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	font_ROM uut (
		.clk(clk), 
		.addr(addr), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
	always begin
	#20 clk =! clk;
	end
	always @(posedge clk) 
      if (addr==11'h7ff)
         addr <= 0;
      else 
         addr <= addr + 1;

endmodule

