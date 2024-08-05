module fetch (
    input clk,
    input [63:0] PC,
    input [0:79] instr,

    output reg [3:0] icode,
    output reg [3:0] ifun,
    output reg [3:0] ra,
    output reg [3:0] rb,
    output reg signed [63:0] valC,
    output reg [63:0] valP,
    output reg imem_error = 1'b0,
    output reg instr_invalid = 1'b0,
    output reg HLT=1'b0
);
    reg need_reg;
    reg need_valc;
    
    initial begin
    need_reg=1'b0;
    need_valc=1'b0;
    end
    always @(*) begin
        if(PC>64'd1023)begin
            imem_error=1'b1;
        end
        else begin
            imem_error=1'b0;
        end
    end
    always @(*) begin
    icode = instr[0:3];
    ifun = instr[4:7];
        case (icode)
        4'b0000: begin                     // Halt
            need_reg <=1'b0; 
            need_valc <=1'b0;
            HLT=1'b1;
            instr_invalid = 1'b0;
        end                             
        4'b0001:  begin                   // NOP
            need_reg <=1'b0; 
            need_valc <=1'b0;
            HLT=1'b0;instr_invalid = 1'b0;
        end      
        4'b0010: begin                   // cmov
            need_reg=1'b1; 
            need_valc=1'b0;
            HLT=1'b0;instr_invalid = 1'b0;
        end         
        4'b0011:  begin                   // irmov
            need_reg=1'b1; 
            need_valc=1'b1;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b0100:  begin                   // rmmov
            need_reg=1'b1; 
            need_valc=1'b1;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b0101:  begin                   //mrmov
            need_reg=1'b1; 
            need_valc=1'b1;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b0110:  begin                    // opq
            need_reg=1'b1; 
            need_valc=1'b0;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b0111:  begin                   // jxx
            need_reg=1'b0; 
            need_valc=1'b1;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b1000:  begin                   // call
            need_reg=1'b0; 
            need_valc=1'b1;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b1001:  begin                   // ret
            need_reg=1'b0; 
            need_valc=1'b0;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b1010:  begin                   // push
            need_reg=1'b1; 
            need_valc=1'b0;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        4'b1011:  begin                   // pop
            need_reg=1'b1; 
            need_valc=1'b0;
            HLT=1'b0;instr_invalid = 1'b0;
        end
        default: instr_invalid = 1'b0;        // Default case
    endcase
    if(need_reg == 1'b1)begin
        ra = instr[8:11];
        rb = instr[12:15];
    end
    else begin
      ra=4'b1111;
      rb=4'b1111;
    end
    if(need_valc == 1'b1 && need_reg == 1'b0)begin
        valC = instr[8:71];
    end
    else if(need_valc == 1'b1 && need_reg == 1'b1)begin
        valC=instr[16:79];
    end
    else begin
        valC=64'd0;
    end
    valP = PC + 1 + need_reg + 8*need_valc;
    end
endmodule