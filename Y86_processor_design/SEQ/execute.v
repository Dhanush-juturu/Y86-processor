`include "ALU.v"
module execute (
  input clk,
  input [3:0] icode,
  input [3:0] ifun,
  input [63:0] valA,valB,valC,
  output reg [63:0] valE, 
  output reg cnd,
  
  output reg cf,
  output reg zf ,
  output reg sf ,
  output reg of
);

  reg [1:0]control;
  reg signed [63:0]ALUa;
  reg signed [63:0]ALUb;
  wire signed [63:0]Alu_out;
  wire overflow;
reg  condition[6:0];

ALU ALU(ALUa,ALUb,control,Alu_out,overflow);

 always@(*)
  begin
        cf = 1'b0;
        zf = (Alu_out == 1'b0);
        sf = (Alu_out<1'b0);
        of = (ALUa<1'b0 == ALUb<1'b0)&&(Alu_out<1'b0 != ALUa<1'b0);
  
        condition[0]  =    1'b1;                       // 
        condition[1]  =    (sf^of)|zf ;                // le
        condition[2]  =    (sf^of);                    // l
        condition[3]  =    zf;                         // e
        condition[4]  =    ~zf;                        // ne
        condition[5]  =    ~(sf^of);                   // ge
        condition[6]  =    (~(sf^of))&(~zf);           // g
  end
   initial begin
    cf = 1'b0;
    zf = 1'b0;
    sf = 1'b0;
    of = 1'b0;
   end
  always@(*)begin
        case (icode)
        4'b0010: begin                   // cmov
            cnd = condition[ifun];
            valE = valA+64'd0;
        end         
        4'b0011:  begin                   // irmov
            valE = 64'd0 + valC;
        end
        4'b0100:  begin                   // rmmov
            valE = valB + valC;
        end
        4'b0101:  begin                   // mrmov
           valE = valB + valC;
        end
        4'b0110:  begin                // opq
            control = ifun[1:0];
            ALUa = valA;
            ALUb = valB;
            valE = Alu_out;
        end
        4'b0111:  begin                   // jxx
            cnd = condition[ifun];
        end
        4'b1000:  begin                   // call
            valE = -64'd8+valB;
        end
        4'b1001:  begin                   // ret
            valE = 64'd8+valB;
        end
        4'b1010:  begin                   // push
            valE = -64'd8+valB;
        end
        4'b1011:  begin                   // pop
            valE = 64'd8+valB;
        end
        default:;        // Default case
    endcase
  end
endmodule

