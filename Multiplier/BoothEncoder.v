`include "IsEven.v"

module booth_encoder 
#(
    parameter DATA_WIDTH = 32,
    parameter NUM_TERMS = $ceil((DATA_WIDTH + 3) / 3),
    parameter CAPACITY_RESULT = (DATA_WIDTH * 2 - 1) * NUM_TERMS
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

wire parity;
is_even #(DATA_WIDTH) is_even_inst(.num(multiplier), 
                     .parity(parity));

wire [DATA_WIDTH + 1:0] ex_multiplier;
assign ex_multiplier = (parity) ?  {2'b00, multiplier, 1'b0} : {1'b0, multiplier, 1'b0};

wire [DATA_WIDTH:0] ir_result [NUM_TERMS - 1:0];

genvar i;
`define j 2 * i + 1
generate
    for (i = 0; i < NUM_TERMS; i = i +1) begin
        wire code;
        assign code = {ex_multiplier[`j + 1], ex_multiplier[`j], ex_multiplier[`j - 1]};
        
        assign ir_result[i] = (code == 3'b000 || code == 3'b111) ? 0                            :
                              (code == 3'b001 || code == 3'b010) ? multiplicand << i            :
                              (code == 3'b011)                   ? double_multiplicand << i     :
                              (code == 3'b100)                   ? neg_double_multiplicand << i :
                              (code == 3'b101 || code == 3'b110) ? neg_multiplicand << i        :
                              0;
    end
endgenerate


genvar x;
`define lsb x * DATA_WIDTH
`define msb x * DATA_WIDTH + DATA_WIDTH - 1
generate
    for (x = 0; x < NUM_TERMS; x = x + 1) begin
        assign result [`msb:`lsb] = ir_result[x];    
    end
endgenerate

endmodule




// genvar i;
// generate
//     for (i = 1; i < DATA_WIDTH; i = i + 2) begin
//         wire code;
//         assign code = {ex_multiplier[i + 1], ex_multiplier[i], ex_multiplier[i - 1]};
        
//         assign result[j] = (code == 3'b000 || code == 3'b111) ?  0 :
//                            (code == 3'b001 || code == 3'b010) ?  1 :
//                            (code == 3'b011) ?  2 :
//                            (code == 3'b100) ? -2 :
//                            (code == 3'b101 || code == 3'b110) ? -1 :
//                            0;
//     end
// endgenerate