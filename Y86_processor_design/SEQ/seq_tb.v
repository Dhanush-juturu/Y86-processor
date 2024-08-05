`include "seq.v"
module seq_tb();

reg clk;
reg [79:0] instr;
reg [63:0] PC;
wire [63:0] new_PC;
wire [63:0] rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,r8,r9,r10,r11,r12,r13,r14;
wire [3:0] stat;
seq proc(clk,PC,instr,new_PC,rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,r8,r9,r10,r11,r12,r13,r14,stat);
reg [0:7] instr_mem[74:0];
always begin
    #5 clk = ~clk;
end
always @(PC) begin
        
    instr={instr_mem[PC],instr_mem[PC+1],instr_mem[PC+2],instr_mem[PC+3],instr_mem[PC+4],instr_mem[PC+5],instr_mem[PC+6],instr_mem[PC+7],instr_mem[PC+8],instr_mem[PC+9]};
 end
 always@(*)begin
    PC=new_PC;
 end
initial begin
    clk = 1'b0;
    PC=16'h0;
    $monitor("\n\nAt T = %4t,clk = %d, \n\ninstr = %b,\t\t\t||\t\tPC=%0d \n\nrax = %0d\t\t\t||\t\trbx= %0d\t\t\t||\t\trcx= %0d\t\t\t||\t\trdx= %0d\t\t\t||\t\trsp= %0d\t\t\t||\t\trbp= %0d\n\nrsi= %0d\t\t\t||\t\trbi= %0d\t\t\t||\t\tr8= %0d\t\t\t||\t\tr9= %0d\n\nr10= %0d\t\t\t||\t\tr11= %0d\t\t\t||\t\tr12= %0d\t\t\t||\t\tr13= %0d\t\t\t||\t\tr14= %0h\n\nstat=%d\n\n",$time,clk,instr,new_PC,rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,r8,r9,r10,r11,r12,r13,r14,stat);

        instr_mem[0] = 8'b0011_0000;//irmovq
        instr_mem[1] = 8'b1111_0011;//rbx
        instr_mem[2] = 8'b0000_0000;//val
        instr_mem[3] = 8'b0000_0000;
        instr_mem[4] = 8'b0000_0000;
        instr_mem[5] = 8'b0000_0000;
        instr_mem[6] = 8'b0000_0000;
        instr_mem[7] = 8'b0000_0000;
        instr_mem[8] = 8'b0000_0000;
        instr_mem[9] = 8'b0000_1000;
        
        instr_mem[10] = 8'b0011_0000;//irmovq
        instr_mem[11] = 8'b1111_0010;//rdx
        instr_mem[12] = 8'b0000_0000;//val
        instr_mem[13] = 8'b0000_0000;
        instr_mem[14] = 8'b0000_0000;
        instr_mem[15] = 8'b0000_0000;
        instr_mem[16] = 8'b0000_0000;
        instr_mem[17] = 8'b0000_0000;
        instr_mem[18] = 8'b0000_0000;
        instr_mem[19] = 8'b0000_0010;
        
        instr_mem[20] = 8'b0110_0000;//addq
        instr_mem[21] = 8'b0010_0011;//rdx , rbx

        instr_mem[22] = 8'b0100_0000;               //rmmovq
        instr_mem[23] = 8'b0010_0000;//rdx
        instr_mem[24] = 8'b0000_0000;//val
        instr_mem[25] = 8'b0000_0000;
        instr_mem[26] = 8'b0000_0000;
        instr_mem[27] = 8'b0000_0000;
        instr_mem[28] = 8'b0000_0000;
        instr_mem[29] = 8'b0000_0000;
        instr_mem[30] = 8'b0000_0000;
        instr_mem[31] = 8'b0000_1000;//-->8

        instr_mem[32] = 8'b1010_0000;//push
        instr_mem[33] = 8'b0010_0000;//rdx

        instr_mem[34] = 8'b1000_0000;//call
        instr_mem[35] = 8'b0000_0000;//val
        instr_mem[36] = 8'b0000_0000;
        instr_mem[37] = 8'b0000_0000;
        instr_mem[38] = 8'b0000_0000;
        instr_mem[39] = 8'b0000_0000;
        instr_mem[40] = 8'b0000_0000;
        instr_mem[41] = 8'b0000_0000;
        instr_mem[42] = 8'b0011_0000;//----->48

        instr_mem[43] = 8'b0000_0000;//HALT
        instr_mem[44] = 8'b0000_0000;
        instr_mem[45] = 8'b0000_0010;
        instr_mem[46] = 8'b0000_0000;
        instr_mem[47] = 8'b0000_0000;

        instr_mem[48] = 8'b0101_0000;//mrmovq
        instr_mem[49] = 8'b1100_0000;//r12
        instr_mem[50] = 8'b0000_0000;//val
        instr_mem[51] = 8'b0000_0000;
        instr_mem[52] = 8'b0000_0000;
        instr_mem[53] = 8'b0000_0000;
        instr_mem[54] = 8'b0000_0000;
        instr_mem[55] = 8'b0000_0000;
        instr_mem[56] = 8'b0000_0000;
        instr_mem[57] = 8'b0000_1000;//--->8

        instr_mem[58] = 8'b0111_0001;//jmp
        instr_mem[59] = 8'b0000_0000;
        instr_mem[60] = 8'b0000_0000;
        instr_mem[61] = 8'b0000_0000;
        instr_mem[62] = 8'b0000_0000;
        instr_mem[63] = 8'b0000_0000;
        instr_mem[64] = 8'b0000_0000;
        instr_mem[65] = 8'b0000_0000;
        instr_mem[66] = 8'b0011_0000;//----->48
        instr_mem[67] = 8'b1001_1000;//ret
        
    #1000;
    $finish;
end
endmodule