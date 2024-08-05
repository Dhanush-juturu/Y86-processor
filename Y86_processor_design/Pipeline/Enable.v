module Enable (
    input  [63:0] a,
    input  [63:0] b,
    input  Enable,
    output [63:0] A,
    output [63:0] B
);
   genvar i;
   generate 
      for(i=0;i<64;i=i+1)
         begin: generate_enable
         and a1(A[i],a[i],Enable);
         and a2(B[i],b[i],Enable);
         end
   endgenerate

endmodule