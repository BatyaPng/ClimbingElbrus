module exp_adder (
    input  [7:0] exp1, exp2,
    output [7:0] exp_sum
);

parameter BIAS = 127;

assign exp_sum = exp1 + exp2 - BIAS;

endmodule