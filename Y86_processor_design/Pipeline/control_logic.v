module Pipeline_Control (
    input [3:0] D_icode, d_srcA, d_srcB,E_icode, E_dstM,M_icode,
    input e_cnd,
    input [0:3] m_stat,W_stat,

    output reg  F_stall, D_stall, D_bubble, E_bubble
);

always @(*)
    begin
        if(D_icode == 4'b1001  &&  (E_icode == 4'b0111 && !e_cnd))  //Combination A
        begin
            F_stall = 1'b1;
            D_bubble = 1'b1; 
            E_bubble = 1'b1;
        end
        else if(((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == d_srcA || E_dstM == d_srcB)) && D_icode == 4'b1001) // Combination B
        begin
            F_stall = 1'b1;
            D_stall = 1'b1; 
            E_bubble = 1'b1;
        end
        else if (D_icode == 4'b1001 || E_icode == 4'b1001 || M_icode == 4'b1001) //ret
        begin
            F_stall = 1'b1;
            D_bubble = 1'b1; 
        end
        else if((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == d_srcA || E_dstM == d_srcB)) //load-use hazard
        begin
            F_stall = 1'b1;
            D_stall = 1'b1;
            E_bubble = 1'b1;
        end
        else if (E_icode == 4'b0111 && !e_cnd) //Jump misprediction
        begin
            D_bubble = 1'b1;
            E_bubble = 1'b1;
        end
        else begin
            F_stall = 1'b0;
            D_stall = 1'b0;
            D_bubble = 1'b0;
            E_bubble = 1'b0;
        end
    end
    
endmodule
