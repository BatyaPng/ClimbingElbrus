module exp_corr (
    input clk, reset,
    input  [45:0] mant_mul,
    input  [7:0] exp_sum,
    output [7:0] exp_res
);

reg [7:0] count;

wire [7:0] index;
assign index = 45 - count;

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
    end else if (mant_mul[index] == 0) begin
        count <= count + 1;
    end
end

endmodule