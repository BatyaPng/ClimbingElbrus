module shift 
#(
    parameter DATA_WIDTH = 8,
    parameter CAPACITY = 2,
    parameter SHIFT_AMOUNT = DATA_WIDTH  
) 
(
    input clk, reset,
    input [DATA_WIDTH] src [CAPACITY],

    output reg [DATA_WIDTH] dst [CAPACITY]
);

genvar i;
generate 
for (i = 0; i < CAPACITY; i = i + 1) begin
always @(posedge clk ) begin
        dst[i] <= src[i] >> SHIFT_AMOUNT;
    end
end
endgenerate

endmodule