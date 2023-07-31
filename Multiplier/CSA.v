module csa (
    input [63:0] num1, num2, num3,

    output [63:0] ps, pc
);

assign ps = num1 ^ num2 ^ num3;
assign pc = (num1 & num2) | (num1 & num2) | (num2 & num3);
    
endmodule