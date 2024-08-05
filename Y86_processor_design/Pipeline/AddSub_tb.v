`include "AddSub.v"
module AdderSubtractor_tb;

   reg [63:0] in1, in2;
   reg M;
   wire [63:0] out;
   wire overflow;

   AdderSubractor uut (
      .in1(in1),
      .in2(in2),
      .M(M),
      .out(out),
      .overflow(overflow)
   );

   initial begin
        $dumpfile("AddSub_out.vcd");
        $dumpvars(0,AdderSubtractor_tb );
      in1 = 64'b1011;
      in2 = 64'b0011;
      M = 0; // Addition
      #10;
      $display("Time: %0t | in1: %0d | in2: %0d | M: %b | out: %0d | overflow: %0b", $time, in1, in2, M, out,overflow);

      in1 = 64'b1000000;
      in2 = 64'b1000000;
      M = 1; // Subtraction
      #10;
      $display("Time: %0t | in1: %0d | in2: %0d | M: %b | out: %0d | overflow: %0b", $time, in1, in2, M, out,overflow);


      $finish;
   end

endmodule
