`include "xor.v"
module XOR_Block_tb;

  reg [63:0] a, b;
  wire [63:0] C;

  XOR_Block uut (
     .a(a),
     .b(b),
     .C(C)
  );

  initial begin
     
     
        $dumpfile("xor_test.vcd");
        $dumpvars(0, XOR_Block_tb);
     a = 64'h00000000_00000000;
     b = 64'h00000000_00000000;
     #10;
     $display("a = %b, b = %b: C = %b", a, b, C);

     a = 64'h12345678_90ABCDEF;
     b = 64'hFEDCBA09_87654321;
     #10;
     $display(" a = %b,\n b = %b:\n C = %b\n\n", a, b, C);

     a = 64'h1011010110001;
     b = 64'h1011010110001;
     #10;
     $display(" a = %b,\n b = %b:\n C = %b\n\n", a, b, C);

     // Add more test cases as needed

     $finish;
  end

endmodule
