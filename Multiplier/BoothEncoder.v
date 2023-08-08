module booth_encoder 
#(
    parameter DATA_WIDTH = 32,
    parameter PARITY = (DATA_WIDTH % 2) ? 0 : 1,
    parameter DATA_WIDTH_TERMS = DATA_WIDTH * 2,
    parameter NUM_TERMS = 12,
    parameter CAPACITY_RESULT = DATA_WIDTH_TERMS * NUM_TERMS
)
(
    input [DATA_WIDTH - 1:0] multiplicand, multiplier, 

    output [CAPACITY_RESULT - 1:0] result
);

wire [DATA_WIDTH:0] neg_multiplicand;
assign neg_multiplicand = -multiplicand;

wire [DATA_WIDTH:0] double_multiplicand;
assign double_multiplicand = {multiplicand, 1'b0};

wire [DATA_WIDTH:0] neg_double_multiplicand;
assign neg_double_multiplicand = -double_multiplicand;

wire [PARITY + 1 + DATA_WIDTH:0] ex_multiplier;
assign ex_multiplier = (PARITY) ?  {2'b00, multiplier, 1'b0} : {1'b0, multiplier, 1'b0};

wire [DATA_WIDTH_TERMS - 1:0] ir_result [NUM_TERMS - 1:0];

generate
    genvar i;
    for (i = 0; i < NUM_TERMS; i = i +1) begin
        wire code;
        assign code = {ex_multiplier[2 * i + 2], ex_multiplier[2 * i + 1], ex_multiplier[2 * i]};
        
        assign ir_result[i] = (code == 3'b000 || code == 3'b111) ? 0                            :
                              (code == 3'b001 || code == 3'b010) ? multiplicand << i            :
                              (code == 3'b011)                   ? double_multiplicand << i     :
                              (code == 3'b100)                   ? neg_double_multiplicand << i :
                              (code == 3'b101 || code == 3'b110) ? neg_multiplicand << i        :
                              0;
    
    end
endgenerate

`define LSB x * DATA_WIDTH_TERMS
`define MSB x * DATA_WIDTH_TERMS + DATA_WIDTH_TERMS - 1
genvar x;
generate
    for (x = 0; x < NUM_TERMS; x = x + 1) begin
        assign result [`MSB:`LSB] = ir_result[x];
    end
endgenerate
`undef LSB
`undef MSB

endmodule