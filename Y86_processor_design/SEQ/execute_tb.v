`include "execute.v"
module Execute_tb();
    reg clk;
    reg [3:0] icode;
    reg [3:0] ifun;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valC;
    wire [63:0] valE; 
    wire Condition;
    wire cf;
    wire zf;
    wire sf;
    wire of;

    execute Execute_tb(.clk(clk),
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .cnd(Condition),
    .cf(cf),
    .zf(zf),
    .sf(sf),
    .of(of));

    
    always begin
        #10 clk = ~clk;
    end

    initial begin
        $monitor("At T = %4t,\n\ticode = %1h, ifun = %1h, valA = %16h, valB = %16h, valC = %16h,\n\tvalE = %16h, Condition = %1b, cf=%b , zf=%b , sf=%b ,of=%b",$time,icode,ifun,valA,valB,valC,valE,Condition,cf,zf,sf,of);

        clk = 0;
        
        #10;
        icode = 4'h2 ; 
        ifun = 4'h0 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ; 

        #10;
        icode = 4'h2 ; 
        ifun = 4'h1 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ; 
        
        #10; 
        icode = 4'h2 ; 
        ifun = 4'h2 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ;


        #10; 
        icode = 4'h2 ; 
        ifun = 4'h3 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ;


        #10; 
        icode = 4'h2 ; 
        ifun = 4'h4 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ;


        #10; 
        icode = 4'h2 ; 
        ifun = 4'h5 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ;


        #10; 
        icode = 4'h2 ; 
        ifun = 4'h6 ; 

        valA = 64'h637b8dbc90e27d04 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h9079b394ce4b0ce6 ;

        #10; 
        icode = 4'h3 ; 
        ifun = 4'h0 ; 

        valA = 64'h228bc5420cea7b08 ; 
        valB = 64'h708ef729cba74d5d ; 
        valC = 64'h407529bee639bcea ;

        #10; 
        icode = 4'h4 ; 
        ifun = 4'h0 ; 

        valA = 64'h237b8dbc90e27d04 ; 
        valB = 64'h71784bac590e2c7d ; 
        valC = 64'h244a50bc27e0394a ;

        #10; 
        icode = 4'h5 ; 
        ifun = 4'h0 ; 

        valA = 64'h3075239bce834dab ; 
        valB = 64'ha18cecbd5b375a8a ; 
        valC = 64'h244a50bc27e0394a ;

        #10; 
        icode = 4'h6 ; 
        ifun = 4'h0 ; 

        valA = 64'h9079b394ce4b0ce6 ; 
        valB = 64'h228bc5420cea7b08 ; 
        valC = 64'h21784bac590e2c7d ;

        #10; 
        icode = 4'h6 ; 
        ifun = 4'h1 ; 

        valA = 64'h9079b394ce4b0ce6 ; 
        valB = 64'h228bc5420cea7b08 ; 
        valC = 64'h21784bac590e2c7d ;

        #10; 
        icode = 4'h6 ; 
        ifun = 4'h2 ; 

        valA = 64'h9079b394ce4b0ce6 ; 
        valB = 64'h228bc5420cea7b08 ; 
        valC = 64'h21784bac590e2c7d ;

        #10; 
        icode = 4'h6 ; 
        ifun = 4'h3 ; 

        valA = 64'h9079b394ce4b0ce6 ; 
        valB = 64'h228bc5420cea7b08 ; 
        valC = 64'h21784bac590e2c7d ;

        #10; 
        icode = 4'h8 ; 
        ifun = 4'h0 ; 

        valA = 64'h268bc9eab567cd74 ; 
        valB = 64'h758cecbd5b375a85 ; 
        valC = 64'h61784bac590e2c7d ;

        #10; 
        icode = 4'h9 ; 
        ifun = 4'h0 ; 

        valA = 64'h744a50bc27e0394a ; 
        valB = 64'h237b8dbc90e27d04 ; 
        valC = 64'h228bc5420cea7b08 ;

        #10; 
        icode = 4'hA ; 
        ifun = 4'h0 ; 

        valA = 64'h293bc8c40ea7be08 ; 
        valB = 64'h2933bcc8c40ea7b8 ; 
        valC = 64'h608ef729cba74d6c ; 


        #10; 
        icode = 4'hB ; 
        ifun = 4'h0 ; 

        valA = 64'h208ef729cba74d6c ; 
        valB = 64'h608ef729cba74d6c ; 
        valC = 64'h407529bee639bcea ; 


        $finish;
           
    end

endmodule