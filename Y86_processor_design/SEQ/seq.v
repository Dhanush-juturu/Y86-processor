`include "fetch.v"
`include "decode_writeback.v"
`include "execute.v"
`include "memory.v"
`include "pc_upd.v"
module seq (
    input clk,
    input [63:0] PC,
    input [0:79] instr,
    output [63:0] new_PC,
    output [63:0] rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,r8,r9,r10,r11,r12,r13,r14,
    output reg [3:0]stat
);
    wire [3:0] icode,ifun,ra,rb;
    wire [63:0] valA,valB,valC,valE,valP,valM;
    wire imem_error,instr_invalid,HLT;
    always@(*) begin
    //   $display("\nFetch\nicode=%0h,ifun=%0h,ra=%0h,rb=%0h,valc=%0h\n",icode,ifun,ra,rb,valC);
      if (instr_invalid==1'b1)begin
        assign stat=4'd3;
        $display("Invalid Instruction");
        $finish;
      end
      else if(HLT==1'b1) begin
        assign stat=4'd4;
        $display("Halt");
        $finish;
      end
      else if(imem_error==1'b1 || dmem_error==1'b1)begin
        assign stat=4'd2;
        $display("Invalid Address");
        $finish;
      end
      else begin
        assign stat=4'd1;
      end
    end
    fetch u1(clk,PC,instr,icode,ifun,ra,rb,valC,valP,imem_error,instr_invalid,HLT);
    wire cnd;
    decode_writeback u2(clk,icode,ra,rb,cnd,valA,valB,valE,valM,rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,r8,r9,r10,r11,r12,r13,r14);

    wire cf,zf,sf,of;
    execute u3 (clk,icode,ifun,valA,valB,valC,valE,cnd,cf,zf,sf,of);

    reg [63:0]data,addr;
    wire [63:0] data_out;
    reg we,re;
    wire dmem_error;
    always@(negedge clk)begin
    case (icode)
        4'b0100:  begin                  // rmmov
            we=1;
            re=0;                  
            addr=valE;
            data=valA;
        end
        4'b0101:  begin                   // mrmov
           re=1;
           we=0;
           addr=valE;
           data=valM;
        end
        4'b1000:  begin                   // call
            we=1;
            re=0;                  
            addr=valE;
            data=valP;
        end
        4'b1001:  begin                   // ret
           re=1;
           we=0;
           addr=valE-64'd8;
           data=valM;
        end
        4'b1010:  begin                   // push
            we=1;
            re=0;                  
            addr=valE;
            data=valA;
        end
        4'b1011:  begin                   // pop
           re=1;
           we=0;
           addr=valE;
           data=valM;
        end
        default:;        // Default case
    endcase
    end    
    memory u4(data,addr,we,re,clk,valM,dmem_error);
    pc_update u5(clk,icode,cnd,valC,valM,valP,new_PC);


endmodule