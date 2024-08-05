module OR_Block (
    input  [63:0] a,
    input  [63:0] b,
    input  [63:0] c,
    output [63:0] out
);
   genvar i;
   generate 
      for(i=0;i<64;i=i+1)
         begin: generate_OR
         or r1(out[i],c[i],a[i],b[i]);
         end
   endgenerate

endmodule