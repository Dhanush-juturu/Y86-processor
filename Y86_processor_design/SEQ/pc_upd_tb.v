`include "pc_upd.v"
module PC_Update_tb();
    reg clk;
    reg condition;
    reg [3:0] icode; 
    reg [63:0] valC;
    reg [63:0] valP;
    reg [63:0] valM;

    wire [63:0] PC;

    pc_update PC_Update_tb(
    .clk(clk),
    .icode(icode),
    .cnd(condition),
    .valC(valC),
    .valM(valM),
    .valP(valP),
    .PC_new(PC));

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $monitor("At T = %4t,\n\ticode = %1h, condition = %1b, valC = %16h, valP = %16h, valM = %16h,\n\tPC = %16h",$time,icode,condition,valC,valP,valM,PC);

        clk = 0; 


        #10; 
        icode = 4'h1; 
        condition = 1'b0;
        valC = 64'h228bc5420cea7b08 ;
        valP = 64'h21784bac590e2c7d ; 
        valM = 64'h768bc9eab567cd74 ;

        #10; 
        icode = 4'h2; 
        condition = 1'b1;
        valC = 64'h228bc5420cea7b08 ; 
        valP = 64'h228bc5420cea7b08 ; 
        valM = 64'h21784bac590e2c7d ;

        #10; 
        icode = 4'h3; 
        condition = 1'b0;
        valC = 64'h758cecbd5b375a85 ; 
        valP = 64'hA18cecbd5b375a85 ; 
        valM = 64'h758cecbd5b375a85 ;

        #10; 
        icode = 4'h4; 
        condition = 1'b0;
        valC = 64'h9079b394ce4b0ce6 ; 
        valP = 64'h208ef729cba74d6c ; 
        valM = 64'ha18cecbd5b375a85 ;

        #10; 
        icode = 4'h5; 
        condition = 1'b0;
        valC = 64'h228bc5420cea7b08 ; 
        valP = 64'h21784bac590e2c7d ; 
        valM = 64'h768bc9eab567cd74 ;

        #10; 
        icode = 4'h7; 
        condition = 1'b1;
        valC = 64'h228bc5420cea7b08 ; 
        valP = 64'h228bc5420cea7b08 ; 
        valM = 64'h21784bac590e2c7d ;

        #10; 
        icode = 4'h8; 
        condition = 1'b0;
        valC = 64'h758cecbd5b375a85 ; 
        valP = 64'hA18cecbd5b375a85 ; 
        valM = 64'h758cecbd5b375a85 ;

        #10; 
        icode = 4'h9; 
        condition = 1'b0;
        valC = 64'h9079b394ce4b0ce6 ; 
        valP = 64'h208ef729cba74d6c ; 
        valM = 64'ha18cecbd5b375a85 ;
    
        $finish;
    end

endmodule