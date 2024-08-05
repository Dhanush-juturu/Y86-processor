module memory(
    input [63:0] data, 
    input [63:0] addr,
    input we, 
    input re, 
    input clk, 
    output reg [63:0] q ,
    output reg dmem_error
);
always @(*) begin
    if(addr>1023)begin
                dmem_error=1'b1;
            end
            else begin
                dmem_error=1'b0;
            end
end
    reg [63:0] ram [1023:0]; 
    always @(clk==0) begin
        if (we)
            ram[addr] = data;
    end
    always @(clk==0) begin
        if (re)
            q = ram[addr];
        else
            q = 64'bx;
    end

endmodule

