`include "fetch.v"
module Fetch_tb();
    reg clk; 
    reg [63:0] PC;
    reg [0:79] Instruction; 
    
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire [63:0] valC;
    wire [63:0] valP;
    wire HLT; 
    wire INS;
    wire ADR;
    
    
    fetch Fetch_tb(.clk(clk),
        .PC(PC),
        .instr(Instruction),
        .icode(icode),
        .ifun(ifun),
        .ra(rA),
        .rb(rB),
        .valC(valC),
        .valP(valP),
        .imem_error(ADR),
        .instr_invalid(INS),
        .HLT(HLT));

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("Fetch.vcd");
        $dumpvars(0, Fetch_tb);

        $monitor("At T = %4t,\n\tclk = %d, Instruction = %20h,\n\ticode = %1h, ifun = %1h, rA = %1h, rB = %1h, valC = %16h, valP = %0h, PC = %0h, InVal Ins = %1b, Address Error = %1b, Halt = %1b,",$time, clk, Instruction, icode, ifun, rA, rB, valC, valP, PC, INS, ADR, HLT);

        clk = 0; PC = 16'h0; //Initial

        //Halt
        #10; Instruction = 80'h00AD7392650AB73E8BCE;
        
        //No Operation
        #10; Instruction = 80'h104842BE8DC9A28D9CE2;

        //Conditional Move
        #10; Instruction = 80'h208ef729cba74d6c92bc;
        #10; Instruction = 80'h21784bac590e2c7d0b47;
        #10; Instruction = 80'h228bc5420cea7b08a479;
        #10; Instruction = 80'h237b8dbc90e27d04b4ac;
        #10; Instruction = 80'h244a50bc27e0394aeb7c;
        #10; Instruction = 80'h258cecbd5b375a85c869;
        #10; Instruction = 80'h268bc9eab567cd742ec2;

        //Imm - Reg Move
        #10; Instruction = 80'h3075239bce834dab49ec;

        //Reg - Mem Move
        #10; Instruction = 80'h407529bee639bcea9d9e;
        
        //Mem - Reg Move
        #10; Instruction = 80'h50739bce027ace484a4c;

        //Arithmetic Operations
        #10; Instruction = 80'h608ef729cba74d6c92bc;
        #10; Instruction = 80'h61784bac590e2c7d0b47;
        #10; Instruction = 80'h628bc5420cea7b08a479;
        #10; Instruction = 80'h637b8dbc90e27d04b4ac;

        //Conditional Jump
        #10; Instruction = 80'h708ef729cba74d6c92bc;
        #10; Instruction = 80'h71784bac590e2c7d0b47;
        #10; Instruction = 80'h728bc5420cea7b08a479;
        #10; Instruction = 80'h737b8dbc90e27d04b4ac;
        #10; Instruction = 80'h744a50bc27e0394aeb7c;
        #10; Instruction = 80'h758cecbd5b375a85c869;
        #10; Instruction = 80'h768bc9eab567cd742ec2;

        //Call
        #10; Instruction = 80'h808bc5420cea7b08a479;

        //Return
        #10; Instruction = 80'h9079b394ce4b0ce67907;

        //Push
        #10; Instruction = 80'hA07b8dbc90e27d04b4ac;

        //Pop
        #10; Instruction = 80'hB08bc9eab567cd742ec2;

        //Checker
        #10; Instruction = 80'hA18cecbd5b375a85c869;

        $finish;

    end
endmodule