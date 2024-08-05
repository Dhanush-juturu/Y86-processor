`include "Enable.v"
module Enable_tb;

  reg [63:0] a, b;
  reg Enable;
  wire [63:0] A, B;

  Enable uut (
     .a(a),
     .b(b),
     .Enable(Enable),
     .A(A),
     .B(B)
  );

  initial begin
     
        $dumpfile("enable_out.vcd");
        $dumpvars(0,Enable_tb );
     
     a = 64'h12345678_90ABCDEF;
     b = 64'hFEDCBA09_87654321;
     Enable = 0;
     #10;
     $display("Enable = 0: A = %h, B = %h", A, B);

     a = 64'h12345678_90ABCDEF;
     b = 64'hFEDCBA09_87654321;
     Enable = 1;
     #10;
     $display("Enable = 1: A = %h, B = %h", A, B);

     $finish;
  end

endmodule
