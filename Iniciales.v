module Iniciales
   (
    input wire clk, 
    input wire [9:0] pix_x, pix_y,
    output wire [3:0] text_on,
    output reg [2:0] text_rgb
   );

   // signal declaration
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_l;
   reg [3:0] row_addr;
   wire [3:0] row_addr_l;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_l;
   wire [7:0] font_word;
   wire font_bit, logo_on;

   // instantiate font ROM
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));

   //-------------------------------------------
   // logo region:
   //   - display logo "PONG" at top center
   //   - used as background
   //   - scale to 64-by-128 font
   //-------------------------------------------
   assign logo_on = (pix_y[9:7]==2) && (3<=pix_x[9:6]) && (pix_x[9:6]<=6);
   assign row_addr_l = pix_y[6:3];
   assign bit_addr_l = pix_x[5:3];
   always @*
      case (pix_x[8:6])
         3'o3: char_addr_l = 7'h45; // E
         3'o4: char_addr_l = 7'h4c; // L
         3'o5: char_addr_l = 7'h43; // C
         default: char_addr_l = 7'h03; // <3
      endcase
   //-------------------------------------------
   // mux for font ROM addresses and rgb
   //-------------------------------------------
   always @*
   begin
      text_rgb = 3'b110;  // background, yellow
       char_addr = char_addr_l;
       row_addr = row_addr_l;
       bit_addr = bit_addr_l;
       if (font_bit)
           text_rgb = 3'b011;
   end

   assign text_on = {logo_on};
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

endmodule
