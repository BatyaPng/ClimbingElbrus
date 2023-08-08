module top();

reg clk = 0;
always begin
    #1 clk = ~clk;
end

reg en = 1;
reg [31:0] a = 27;
reg [31:0] b = 15;
wire [63:0] res;
wire val;
wire overflow;





muliplier multiplier_inst(.clk(clk), .en(en), 
                          .op1(a), .op2(b), 
                          .res(res),
                          .val(val),
                          .overflow(overflow));


initial begin
    $dumpvars;

    #10;

    $finish;
end

endmodule