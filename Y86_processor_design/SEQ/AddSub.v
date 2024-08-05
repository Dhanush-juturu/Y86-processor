module AdderSubractor (
    input [63:0] in1,
    input [63:0] in2,
    input M,
    output [63:0] out,
    output overflow
);

wire [63:0] inp1,inp2;
genvar i;
//XORing with M 
   generate 
      for(i=0;i<64;i=i+1)
         begin: generate_XOR_with_M
         xor x1(inp1[i],in1[i],0);
         xor x2(inp2[i],in2[i],M);
         end
   endgenerate

wire [63:0] carry;
// Generating ADD/Sub
   generate 
   for(i=0;i<64;i=i+1)
     begin: generate_Add_Sub
        if(i==0) 
            FullAdder FA(inp1[0],inp2[0],M,out[0],carry[0]);
        else
            FullAdder FA(inp1[i],inp2[i],carry[i-1],out[i],carry[i]);
    end
        assign overflow = carry[63];
   endgenerate

endmodule


// Full Adder
module FullAdder (
    input  a,
    input  b,
    input  cin,
    output s,
    output cout
);
  wire y1, y2, y3;
  xor (y1, a, b);
  and (y2, a, b);
  xor (s, y1, cin);
  and (y3, y1, cin);
  or (cout, y2, y3);
endmodule