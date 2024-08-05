module Memory_Pipe (
    input clk,
    input [3:0] M_icode, M_dstE, M_dstM,
    input [63:0] M_valE, M_valA,
    input [0:3] M_stat,
    input M_cnd,

    output reg [3:0] W_icode, W_dstE, W_dstM,
    output reg [63:0] W_valE, W_valM,
    output reg [0:3] W_stat,

    output reg [63:0] m_valM,
    output reg [0:3] m_stat
);
    reg [63:0] ram [8191:0];
    reg dmem_error;


    always @(*)begin
        if(M_valE > 8191 || M_valA > 8191)
        begin
            dmem_error = 1;
        end
        if(dmem_error == 1)
        m_stat = 4'h3;
        else
        m_stat = M_stat;
        case(M_icode)
            4'b0101: m_valM = ram [M_valE];   //mrmovq
            4'b1001: m_valM = ram [M_valA];   //return
            4'b1011: m_valM = ram [M_valA];   //popq   
        endcase
        
    end

    always@(posedge clk)
    begin
        case(M_icode)
            4'b0100: ram [M_valE] = M_valA;   //rmmovq
            4'b1000: ram [M_valE] = M_valA;   //call
            4'b1010: ram [M_valE] = M_valA;   //pushq 
        endcase
    end

    // writing to pipeline registers;
    always @(posedge clk)
    begin
        W_icode <= M_icode;
        W_valE <= M_valE;
        W_dstM <= M_dstM;
        W_stat <= m_stat;
        W_valM <= m_valM;
        W_dstE <= M_dstE;
    end
endmodule
