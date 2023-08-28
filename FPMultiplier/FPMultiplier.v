module fp_multiplier (
    input clk, en,
    input [31:0] num1, num2,

    output reg [31:0] res,
    output reg val
);

wire sign1, sign2;
assign sign1 = num1[31];
assign sign2 = num2[31];

wire [8:0] exp1, exp2;
assign exp1 = num1[30:23];
assign exp2 = num2[30:23];

wire [22:0] mant1, mant2;
assign mant1 = num1[22:0];
assign mant2 = num2[22:0];

wire [45:0] mant_mul_res;
wire man_val;
wire overflow;
multiplier #(23) mant_mul  (.clk(clk), .en(en),
                    .op1(mant1), .op2(mant2),
                    .res(mant_mul_res),
                    .val(man_val), .overflow(overflow)    
);

endmodule