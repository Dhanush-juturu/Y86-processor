module decode_writeback (
    input clk,
    input [3:0] icode,
    input [3:0] rA,
    input [3:0] rB,
    input cnd,
    output reg [63:0] valA,
    output reg [63:0] valB,
    input [63:0] valE,
    input [63:0] valM,

    output reg [63:0] rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,r8,r9,r10,r11,r12,r13,r14
);        

reg [63:0] reg_file[0:14];
  initial begin
    reg_file[0]  =  64'd0;    
    reg_file[1]  =  64'd0;    
    reg_file[2]  =  64'd0;    
    reg_file[3]  =  64'd0;    
    reg_file[4]  =  64'd50;    
    reg_file[5]  =  64'd0;    
    reg_file[6]  =  64'd0;    
    reg_file[7]  =  64'd0;    
    reg_file[8]  =  64'd0;    
    reg_file[9]  =  64'd0;    
    reg_file[10] =  64'd0;
    reg_file[11] =  64'd0;
    reg_file[12] =  64'd0;
    reg_file[13] =  64'd0;
    reg_file[14] =  64'd0;
  end

  //Decode
  always @(*) begin
        if (icode == 4'b0000) begin // halt 
        end
        else if (icode == 4'b0001) begin // nop
        end
        else if (icode == 4'b0010) begin // cmovXX
            valA = reg_file[rA];
            valB = 64'd0;
        end
        else if (icode == 4'b0011) begin // irmov
        end
        else if (icode == 4'b0100) begin // rmmovq
            valA = reg_file[rA];
            valB = reg_file[rB];
        end
        else if (icode == 4'b0101) begin // mrmovq
            valB = reg_file[rB];
        end
        else if (icode == 4'b0110) begin // opq
            valA = reg_file[rA];
            valB = reg_file[rB];
        end
        else if (icode == 4'b0111) begin // jxx
        end
        else if (icode == 4'b1000) begin // call
            valB = reg_file[4];
        end
        else if (icode == 4'b1001) begin // ret
            valA = reg_file[4];
            valB = reg_file[4];
        end
        else if (icode == 4'b1010) begin // pushq
            valA = reg_file[rA];
            valB = reg_file[4];
        end
        else if (icode == 4'b1011) begin // popq
            valA = reg_file[4];
            valB = reg_file[4];
        end
end
//Write Back
always @(posedge clk) begin
        if (icode == 4'b0000) begin // halt 
        end
        else if (icode == 4'b0001) begin // nop
        end
        else if (icode == 4'b0010) begin // cmovXX
          if(cnd ==1'b1)begin
            reg_file[rB] = valE;
          end
        end
        else if (icode == 4'b0011) begin // irmov
            reg_file[rB] = valE;
        end
        else if (icode == 4'b0100) begin // rmmovq
        end
        else if (icode == 4'b0101) begin // mrmovq
            reg_file[rA] = valM;
        end
        else if (icode == 4'b0110) begin // opq
            reg_file[rB] = valE;
        end
        else if (icode == 4'b0111) begin // jxx 
        if(cnd ==1'b1)begin
            reg_file[rB] = valE;
          end
        end
        else if (icode == 4'b1000) begin // call
            reg_file[4] = valE;
        end
        else if (icode == 4'b1001) begin // ret
            reg_file[4] = valE;
        end
        else if (icode == 4'b1010) begin // pushq
            reg_file[4] = valE;
        end
        else if (icode == 4'b1011) begin // popq
            reg_file[4] = valE;
            reg_file[rA] = valM;
        end

        rax = reg_file[0];    
        rcx = reg_file[1];    
        rdx = reg_file[2];    
        rbx = reg_file[3];    
        rsp = reg_file[4];    
        rbp = reg_file[5];    
        rsi = reg_file[6];    
        rbi = reg_file[7];    
        r8  = reg_file[8];    
        r9  = reg_file[9];    
        r10 = reg_file[10];
        r11 = reg_file[11];
        r12 = reg_file[12];
        r13 = reg_file[13];
        r14 = reg_file[14];
end
    
endmodule