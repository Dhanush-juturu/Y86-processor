`include "ALU.v"
module Execute_Pipe (
    input clk,
    input [3:0] E_icode, E_ifun, E_dstE, E_dstM, E_srcA, E_srcB,   
    input [63:0] E_valC, E_valA, E_valB,        
    input [0:3] E_stat,

    input [0:3] W_stat,m_stat,

    output reg [3:0] e_dstE,
    output reg [63:0] e_valE,


    output reg [3:0] M_icode, M_dstE, M_dstM,
    output reg [63:0] M_valE, M_valA,
    output reg [0:3] M_stat,
    output reg M_cnd,e_cnd
);
    
    reg [1:0]control;
    reg signed [63:0]ALUa;
    reg signed [63:0]ALUb;
    wire signed [63:0]Alu_out;
    wire overflow;
    reg  condition[6:0];
    reg cf,zf,sf,of;

    initial begin
        cf = 1'b0;
        zf = 1'b0;
        sf = 1'b0;
        of = 1'b0;
    end


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



    always@(*)begin
        case (E_icode)
            4'b0010: begin                   // cmov
                e_cnd = condition[E_ifun];
                e_valE = E_valA+64'd0;
            end         
            4'b0011:  begin                   // irmov
                e_valE = 64'd0 + E_valC;
            end
            4'b0100:  begin                   // rmmov
                e_valE = E_valB + E_valC;
            end
            4'b0101:  begin                   // mrmov
            e_valE = E_valB + E_valC;
            end
            4'b0110:  begin                // opq
                control = E_ifun[1:0];
                ALUa = E_valA;
                ALUb = E_valB;
                e_valE = Alu_out;
            end
            4'b0111:  begin                   // jxx
                e_cnd = condition[E_ifun];
            end
            4'b1000:  begin                   // call
                e_valE = -64'd8+E_valB;
            end
            4'b1001:  begin                   // ret
                e_valE = 64'd8+E_valB;
            end
            4'b1010:  begin                   // push
                e_valE = -64'd8+E_valB;
            end
            4'b1011:  begin                   // pop
                e_valE = 64'd8+E_valB;
            end
            default:;        // Default case
        endcase
    end


    //checking for condition;
    always @(*)
    begin
        if(E_icode == 2 || E_icode == 7)
        begin
            e_dstE = (e_cnd == 1) ? E_dstE : 4'b1111;
        end
        else
        begin
            e_dstE = E_dstE;
        end
    end

    // writiing to pipeline registers;
    always @(posedge clk)
    begin
        M_stat <= E_stat;
        M_cnd <= e_cnd;
        M_valA <= E_valA;
        M_dstM <= E_dstM;
        M_icode <= E_icode;
        M_valE <= e_valE;
        M_dstE <= e_dstE;
    end
endmodule
