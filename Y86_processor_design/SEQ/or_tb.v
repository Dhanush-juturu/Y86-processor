`include "or.v"
module OR_Block_tb;

   reg [63:0] a, b, c;
   wire [63:0] out;

   OR_Block uut (
      .a(a),
      .b(b),
      .c(c),
      .out(out)
   );

   initial begin
      // Test case 1: All inputs 0
      
        $dumpfile("or_out.vcd");
        $dumpvars(0,OR_Block_tb );
      a = 64'h00000000_00000000;
      b = 64'h00000000_00000000;
      c = 64'h00000000_00000000;
      #10;
      $display("a = %0b,\n b = %0b,\n c = %0b: \nout = %0b\n\n", a, b, c, out);

      // Test case 2: Various input combinations
      a = 64'h12345678_90ABCDEF;
      b = 64'hFEDCBA09_87654321;
      c = 64'h01234567_89ABCDEF;
      #10;
      $display("a = %b, \nb = %b, \nc = %b: \nout=%b\n", a, b, c, out);

      // Test case 3: All inputs 1
      a = 64'h110101011;
      b = 64'h1101011011;
      c = 64'h011010110;
      #10;
      $display(" a = %0b,\n b = %0b,\n c = %0b:\n out=%0b\n\n", a, b, c, out);

      // Add more test cases as needed

      $finish;
   end

endmodule
