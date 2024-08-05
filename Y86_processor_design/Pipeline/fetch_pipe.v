module Fetch_Pipe (
input clk,
input F_stall, D_stall, D_bubble, M_cnd,    
input [3:0] M_icode, W_icode,                   
input [63:0] M_valA, W_valM, F_predPC,      

//for next intsruction
output reg [63:0] f_predPC,                  
// for next stage pipe line registers
output reg [3:0] D_icode, D_ifun, D_rA, D_rB,     
output reg signed [63:0] D_valC, D_valP,        
output reg [0:3] D_stat               
);
    reg [0:7] instr_mem[1023:0];
    reg need_reg;
    reg need_valc;
    reg [63:0] f_PC;
    reg [3:0] f_icode,f_ifun,f_rA,f_rB;
    reg [63:0] f_valC,f_valP;
    reg [0:79] instruction;
    reg imem_error ,instr_invalid;
    reg [0:3] f_stat;

    initial begin
        need_reg=1'b0;
        need_valc=1'b0;
        f_PC=F_predPC;
        $readmemb("input.txt",instr_mem);   
        // clk=1'b0;
    end
    // always #5 clk=~clk;


    //imem error
    always @(*) begin
        if(f_PC>64'd1023)begin
            imem_error=1'b1;
        end
        else begin
            imem_error=1'b0;
        end
    end


    //Handling PC changes;
    always@(*) begin
        if(W_icode==4'b1001)
            f_PC = W_valM;            // getting return PC value from WriteBack
        else if(M_icode==4'b0111 & !M_cnd)
            f_PC = M_valA;            // misprediction of branch
        else
            f_PC = F_predPC;     
    end


    // assigning stat code
    always @(*)begin
        if (instr_invalid)
        f_stat = 4'h2;
        else if (imem_error)
        f_stat = 4'h3;
        else if (f_icode==4'h0)
        f_stat = 4'h4;
        else 
        f_stat = 4'h1;
    end

    //assigning instruction based on PC
    always @(*)begin
        instruction = {instr_mem[f_PC],instr_mem[f_PC+1],instr_mem[f_PC+2],instr_mem[f_PC+3],instr_mem[f_PC+4],instr_mem[f_PC+5],instr_mem[f_PC+6],instr_mem[f_PC+7],instr_mem[f_PC+8],instr_mem[f_PC+9]};
        f_icode = instruction[0:3];
        f_ifun = instruction[4:7];
    end

    //  assign icode,ifun,need_reg,need_valc
    always @(*) begin
        case (f_icode)
            4'b0000: begin                     // Halt
                need_reg =1'b0; 
                need_valc =1'b0;
                instr_invalid = 1'b0;
            end                             
            4'b0001:  begin                   // NOP
                need_reg =1'b0; 
                need_valc =1'b0;
                instr_invalid = 1'b0;
            end      
            4'b0010: begin                   // cmov
                need_reg=1'b1; 
                need_valc=1'b0;
                instr_invalid = 1'b0;
            end         
            4'b0011:  begin                   // irmov
                need_reg=1'b1; 
                need_valc=1'b1;
                instr_invalid = 1'b0;
            end
            4'b0100:  begin                   // rmmov
                need_reg=1'b1; 
                need_valc=1'b1;
                instr_invalid = 1'b0;
            end
            4'b0101:  begin                   //mrmov
                need_reg=1'b1; 
                need_valc=1'b1;
                instr_invalid = 1'b0;
            end
            4'b0110:  begin                    // opq
                need_reg=1'b1; 
                need_valc=1'b0;
                instr_invalid = 1'b0;
            end
            4'b0111:  begin                   // jxx
                need_reg=1'b0; 
                need_valc=1'b1;
                instr_invalid = 1'b0;
            end
            4'b1000:  begin                   // call
                need_reg=1'b0; 
                need_valc=1'b1;
                instr_invalid = 1'b0;
            end
            4'b1001:  begin                   // ret
                need_reg=1'b0; 
                need_valc=1'b0;
                instr_invalid = 1'b0;
            end
            4'b1010:  begin                   // push
                need_reg=1'b1; 
                need_valc=1'b0;
                instr_invalid = 1'b0;
            end
            4'b1011:  begin                   // pop
                need_reg=1'b1; 
                need_valc=1'b0;
                instr_invalid = 1'b0;
            end
            default: instr_invalid = 1'b1;        // Default case
        endcase


        //assign rA,rB,valC,valP,predicted_PC;
        f_valP = f_PC + 1 + need_reg + 8*need_valc;
        if(need_reg == 1'b1)begin
            f_rA = instruction[8:11];
            f_rB = instruction[12:15];
            f_predPC=f_valP;        // predicted PC will be valP
        end
        else begin
        f_rA=4'b1111;
        f_rB=4'b1111;
        end
        if(need_valc == 1'b1 && need_reg == 1'b0)begin
            f_valC = instruction[8:71];
            f_predPC=f_valC;                      // Predicting cnd will be true;
        end
        else if(need_valc == 1'b1 && need_reg == 1'b1)begin
            f_valC=instruction[16:79];
        end
        else begin
            f_valC=64'd0;
        end
    end


    // writing to pipeline registers;
    always @(posedge clk ) begin
        if (F_stall==1'b1)
        begin
            f_PC = F_predPC;   
        end
        
        if (D_bubble==1'b1)
        begin
            D_icode <= 4'h1;
            D_ifun <= 4'h0;
            D_rB <= 4'hF;
            D_valP <= 64'b0;
            D_rA <= 4'hF;
            D_valC <= 64'b0;
            D_stat <= 4'h1;
        end
        else if(D_stall==1'b1)
        begin
            
        end
        else
        begin
            D_icode <= f_icode;
            D_rA <= f_rA;
            D_valC <= f_valC;
            D_stat <= f_stat;
            D_ifun <= f_ifun;
            D_rB <= f_rB;
            D_valP <= f_valP;
        end

    end


endmodule
