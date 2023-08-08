module csa 
#(
    parameter DATA_WIDTH = 63
)
(
    input [DATA_WIDTH - 1:0] num1, num2, num3,

    output [DATA_WIDTH - 1:0] ps, pc
);

assign ps = num1 ^ num2 ^ num3;
assign pc = (num1 & num2) | (num1 & num2) | (num2 & num3);
    
endmodule