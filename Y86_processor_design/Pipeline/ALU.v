`include "Decoder.v"
`include "Enable.v"
`include "and.v"
`include "AddSub.v"
`include "xor.v"
`include "or.v"
module ALU(
input [63:0] in1,
input [63:0] in2,
input [1:0] control,
output [63:0] out,
output overflow
);
wire enas1,enas2,ena,enx,enas;
Decoder D1(control[1],control[0],enas1,enas2,ena,enx);
or(enas,enas1,enas2);
wire [63:0] inas1,inas2,ina1,ina2,inx1,inx2;
Enable en1(in1,in2,enas,inas1,inas2);
Enable en2(in1,in2,ena,ina1,ina2);
Enable en3(in1,in2,enx,inx1,inx2);
wire[63:0] outas,outa,outx;
AdderSubractor as(inas1,inas2,control[0],outas,overflow);
AND_Block andblock(ina1,ina2,outa);
XOR_Block xorblock(inx1,inx2,outx);
OR_Block orblock(outas,outa,outx,out);
endmodule
