`include "ALU.v"
module ALU_tb;

   reg  [63:0] in1, in2;
   reg  [1:0] control;
   wire [63:0] out;
   wire overflow;

   ALU uut (
      .in1(in1),
      .in2(in2),
      .control(control),
      .out(out),
      .overflow(overflow)
   );

   initial begin
        $dumpfile("ALU_out.vcd");
        $dumpvars(0,ALU_tb );

      in1 = 64'd20;
      in2 = 64'd30;
      control = 2'b00;  // addition
      #10;
      $display("Time: %0t | in1: %0d | in2: %0d | control: %b | out: %0d overflow: %b", $time, in1, in2, control, out,overflow);

      in1 = 64'd30;
      in2 = 64'd10;
      control = 2'b01;  //subtraction
      #10;
      $display("Time: %0t | in1: %0d | in2: %0d | control: %b | out: %0d | overflow: %b", $time, in1, in2, control, out,overflow);

      in1 = 64'b1011;
      in2 = 64'b1100;
      control = 2'b10;  //AND
      #10;
      $display("Time: %0t | in1: %0b | in2: %0b | control: %b | out: %0b overflow: %b", $time, in1, in2, control, out,overflow);

      in1 = 64'b1011001;
      in2 = 64'b1010010;
      control = 2'b11;  //XOR
      #10;
      $display("Time: %0t | in1: %0b | in2: %0b | control: %b | out: %0b overflow: %b", $time, in1, in2, control, out,overflow);

      $finish;
   end

endmodule
