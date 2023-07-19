module top();

reg clk = 1'b1, reset = 1'b1;


wire clk_div, impulse;

always begin
    #1 clk = ~clk;
end

// clk_div_2n #(2) clk_div2_inst(.clk(clk), .reset(reset), .clk_div(clk_div));
// clk_div_2n #(4) clk_div2_inst(.clk(clk), .reset(reset), .clk_div(clk_div));
clk_div_2n #(6) clk_div2_inst(.clk(clk), .reset(reset), .clk_div(clk_div));

initial begin
    $dumpvars;
    #2 reset = 0;

    #100 $finish;
end

endmodule