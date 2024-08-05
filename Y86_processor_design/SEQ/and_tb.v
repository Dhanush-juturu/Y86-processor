`include "and.v"
module AND_Block_tb;

   reg  [63:0] a;
   reg  [63:0] b;
   wire [63:0] C;

   AND_Block uut (
      .a(a),
      .b(b),
      .C(C)
   );

   initial begin
      
      
        $dumpfile("and.vcd");
        $dumpvars(0,AND_Block_tb );
      a = 64'b0;
      b = 64'b0;
      #10;
      $display("Time: %0t | a: %b | b: %b | C: %b\n", $time, a, b, C);

      a = 64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111;
      b = 64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111;
      #10;
      $display("Time: %0t | a: %b | b: %b | C: %b\n", $time, a, b, C);

      a = 64'b10101010_10101010_10101010_10101010_10101010_10101010_10101010_10101010;
      b = 64'b01010101_01010101_01010101_01010101_01010101_01010101_01010101_01010101;
      #10;
      $display("Time: %0t | a: %b | b: %b | C: %b\n", $time, a, b, C);


      $finish;
   end

endmodule
