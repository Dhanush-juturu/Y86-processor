`include "decode_writeback.v"
module Decode_Writeback_tb();
    reg clk,Condition; 
    reg [3:0] icode;
    reg [3:0] rA;
    reg [3:0] rB;
    reg [63:0] valE; 
    reg [63:0] valM; 
    
    wire [63:0] valA;
    wire [63:0] valB;
    wire [63:0] rax;
    wire [63:0] rbx;
    wire [63:0] rcx;
    wire [63:0] rdx;
    wire [63:0] rsp;
    wire [63:0] rbp;
    wire [63:0] rsi;
    wire [63:0] rdi;
    wire [63:0] r8;
    wire [63:0] r9;
    wire [63:0] r10;
    wire [63:0] r11;
    wire [63:0] r12;
    wire [63:0] r13;
    wire [63:0] r14; 

    decode_writeback uut (
        .clk(clk),
        .icode(icode),
        .rA(rA),
        .rB(rB),
        .cnd(Condition),
        .valA(valA),
        .valB(valB),
        .valE(valE),
        .valM(valM),
        .rax(rax),
        .rbx(rbx),
        .rcx(rcx),
        .rdx(rdx),
        .rsp(rsp),
        .rbp(rbp),
        .rsi(rsi),
        .rbi(rdi),
        .r8(r8),
        .r9(r9),
        .r10(r10),
        .r11(r11),
        .r12(r12),
        .r13(r13),
        .r14(r14)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $monitor("At T = %4t,\n\t icode = %1h, rA = %1h, rB = %1h, valA = %16h, valB = %16h \n\t Condition = %1b, valE = %16h, valM = %16h , rax = %16h, rbx = %16h, rcx = %16h, rdx = %16h, rsp = %16h, rbp = %16h, rsi = %16h, rdi = %16h, r8 = %16h, r9 = %16h, r10 = %16h, r11 = %16h, r12 = %16h, r13 = %16h, r14 = %16h",$time, icode,rA,rB,valA,valB,Condition,valE,valM,rax,rbx,rcx,rdx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14);

        clk = 0;

        #10; 
        icode = 4'h3; 
        rA = 4'he ; 
        rB = 4'h1;
        Condition = 1'b0 ; 
        valE = 64'h768bc9eab567cd74 ; 
        valM = 64'h637b8dbc90e27d04;


        #10; 
        icode = 4'h3; 
        rA = 4'h1 ; 
        rB = 4'he;
        Condition = 1'b0 ; 
        valE = 64'h768bc9eab567cd74 ; 
        valM = 64'h637b8dbc90e27d04;


        #10; 
        icode = 4'h2; 
        rA = 4'h1 ; 
        rB = 4'h0;
        Condition = 1'b1 ; 
        valE = 64'h758cecbd5b375a85 ; 
        valM = 64'hA18cecbd5b375a85;



        $finish;
        
    end
endmodule