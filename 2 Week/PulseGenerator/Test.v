module top();

reg clk = 1, reset = 1;

wire impulse;

always begin
    #1 clk = ~clk;
end

pls_gen_n #(4) pls_gen_n_inst(.clk(clk), .reset(reset), .impulse(impulse));

initial begin
    $dumpvars;
    
    #1 reset = 0;

    #100 $finish;
end

endmodule