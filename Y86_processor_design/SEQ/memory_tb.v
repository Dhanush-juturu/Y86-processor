
`include "memory.v"
module single_port_ram_tb;


    reg [63:0] data;
    reg [63:0] addr;
    reg we, re, clk;

    wire dmem_error;
    wire [63:0] q;

    memory uut (
        .data(data), 
        .addr(addr), 
        .we(we), 
        .re(re), 
        .clk(clk), 
        .q(q),
        .dmem_error(dmem_error)
    );

    initial begin
       
        data = 0;
        addr = 0;
        we = 0;
        re = 0;
        clk = 0;

        forever #5 clk = ~clk; 
    end

    initial begin
       
        $dumpfile("dump.vcd");
        $dumpvars(0, single_port_ram_tb);

        #10;
        data = 64'h1234567890ABCDEF;
        addr = 10'd5;
        we = 1;
        re = 0;
        #10;
        we = 0;

        #20;
        addr = 10'd5;
        re = 1;
        #10;
        re = 0;

        #30;
        data = 64'hFFFFFFFFFFFFFFFF;
        addr = 10'd5;
        we = 1;
        re = 1;
        #10;
        we = 0;
        re = 0;

    
        #40;
        data = 64'hA5A5A5A5A5A5A5A5;
        addr = 10'd20;
        we = 1;
        #10;
        we = 0;

        #50;
        addr = 10'd20;
        re = 1;
        #10;
        re = 0;

        #60;
        $finish;
    end

    initial begin
        $monitor("Time = %d : addr = %d, data = %h, we = %b, re = %b, q = %h", 
                 $time, addr, data, we, re, q);
    end
      
endmodule
