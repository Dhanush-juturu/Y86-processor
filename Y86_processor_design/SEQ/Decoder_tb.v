`include "Decoder.v"
module Decoder_tb;

  reg S0, S1;
  wire D0, D1, D2, D3;

  Decoder uut (
     .S0(S0),
     .S1(S1),
     .D0(D0),
     .D1(D1),
     .D2(D2),
     .D3(D3)
  );

  initial begin

     
        $dumpfile("Decoder.vcd");
        $dumpvars(0, Decoder_tb);
     S0 = 0; S1 = 0; #10; $display("S0 = %b, S1 = %b: D0 = %b, D1 = %b, D2 = %b, D3 = %b", S0, S1, D0, D1, D2, D3);
     S0 = 0; S1 = 1; #10; $display("S0 = %b, S1 = %b: D0 = %b, D1 = %b, D2 = %b, D3 = %b", S0, S1, D0, D1, D2, D3);
     S0 = 1; S1 = 0; #10; $display("S0 = %b, S1 = %b: D0 = %b, D1 = %b, D2 = %b, D3 = %b", S0, S1, D0, D1, D2, D3);
     S0 = 1; S1 = 1; #10; $display("S0 = %b, S1 = %b: D0 = %b, D1 = %b, D2 = %b, D3 = %b", S0, S1, D0, D1, D2, D3);

     $finish;
  end

endmodule
