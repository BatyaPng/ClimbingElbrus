module exp_corr (
    input clk, reset,
    input  [47:0] mant_mul,
    input  [7:0] exp_sum,
    output [7:0] exp_res
);

assign exp_res = (mant_mul[47] == 1) ? exp_sum : exp_sum - 1;

endmodule