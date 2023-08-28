module multiplier 
#(
    parameter DATA_WIDTH = 32,
    parameter DATA_WIDTH_RES = DATA_WIDTH * 2,
    parameter DATA_WIDTH_TERMS = DATA_WIDTH * 2,
    parameter NUM_TERMS = $ceil((DATA_WIDTH + 2) / 2),
    parameter CAPACITY_RESULT_BE = DATA_WIDTH_TERMS * NUM_TERMS
)
(
    input clk, en,
    input [DATA_WIDTH - 1:0] op1, op2,

    output reg [DATA_WIDTH_RES - 1:0] res,
    output reg val, 
    output overflow
);
    
wire [CAPACITY_RESULT_BE - 1:0] be_result;
booth_encoder #(DATA_WIDTH) be_inst(.multiplicand(op1), .multiplier(op2),
                      .result(be_result));

wire [2 * DATA_WIDTH_TERMS - 1:0] tmp_mid_result;
csa_tree #(DATA_WIDTH_TERMS) csa_tree_inst(.terms(be_result),
                       .result(tmp_mid_result));

reg [2 * DATA_WIDTH_TERMS - 1:0] mid_result;
always @(posedge clk) begin
    if (en) begin
        mid_result <= tmp_mid_result;
    end
end

always @(posedge clk) begin
    val <= en;
end

assign overflow = ~(res[63:32] == 33'b0);

always @(posedge clk) begin
    res <= mid_result[63:32] + mid_result[31:0];
end



endmodule   