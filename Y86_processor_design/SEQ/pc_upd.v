module pc_update (
    input clk,
    input [3:0] icode,
    input cnd,
    input [63:0] valC, valM, valP,
    output reg [63:0] PC_new
);
always @(posedge clk) begin
    case (icode)
        4'b0000: PC_new = 64'b0;         // Halt
        4'b0001: PC_new = valP;          // NOP
        4'b0010: PC_new = valP;          // CMOVXX
        4'b0011: PC_new = valP;          // IRMOVQ
        4'b0100: PC_new = valP;          // RMMOVQ
        4'b0101: PC_new = valP;          // MRMOVQ
        4'b0110: PC_new = valP;          // OPQ
        4'b0111: PC_new = (cnd == 1) ? valC : valP; // JXX
        4'b1000: PC_new = valC;          // CALL
        4'b1001: PC_new = valM;          // RET
        4'b1010: PC_new = valP;          // PUSHQ
        4'b1011: PC_new = valP;          // POPQ
        default: PC_new = valP;        // Default case
    endcase
end
endmodule