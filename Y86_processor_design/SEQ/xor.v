module XOR_Block (
    input  [63:0] a,
    input  [63:0] b,
    output [63:0] C
);
   genvar i;
   generate 
      for(i=0;i<64;i=i+1)
         begin: generate_XOR
         xor x1(C[i],a[i],b[i]);
         end
   endgenerate

endmodule