module csa_tree
#(
    parameter DATA_WIDTH = 64,
    parameter NUM_TERMS = $ceil((DATA_WIDTH / 2 + 2) / 2),
    parameter CAPACITY_INPUT = DATA_WIDTH * NUM_TERMS,
    parameter CAPACITY_RESULT = 2 * DATA_WIDTH  
)
(
    input [CAPACITY_INPUT - 1:0] terms,

    output [CAPACITY_RESULT - 1:0] result
);

wire [DATA_WIDTH - 1:0] terms_array [NUM_TERMS - 1:0];
`define LSB i * DATA_WIDTH
`define MSB i * DATA_WIDTH + DATA_WIDTH - 1
generate
    genvar i;
    for (i = 0; i < NUM_TERMS; i = i + 1) begin
        assign terms_array[i] = terms[`MSB:`LSB];
    end
endgenerate
`undef LSB
`undef MSB

wire [DATA_WIDTH - 1:0] output_1_layer [7:0];
generate
    genvar i_1;
    for (i_1 = 0; i_1 < 4; i_1 = i_1 + 1) begin
        csa #(DATA_WIDTH) csa_1_layer(.num1(terms_array[3 * i_1]), .num2(terms_array[3 * i_1 + 1]), .num3(terms_array[3 * i_1 + 2]),
                        .ps(output_1_layer[2 * i_1]), .pc(output_1_layer[2 * i_1 + 1]));
    end
endgenerate

wire [DATA_WIDTH - 1:0] output_2_layer [3:0];
csa #(DATA_WIDTH)csa_2_layer_1(.num1(output_1_layer[0]), .num2(output_1_layer[1]), .num3(output_1_layer[2]),
                .ps(output_2_layer[0]), .pc(output_2_layer[1]));
csa #(DATA_WIDTH)csa_2_layer_2(.num1(output_1_layer[3]), .num2(output_1_layer[4]), .num3(output_1_layer[5]),
                .ps(output_2_layer[2]), .pc(output_2_layer[3]));

wire [DATA_WIDTH - 1:0] output_3_layer [1:0];
csa #(DATA_WIDTH)csa_3_layer(.num1(output_2_layer[0]), .num2(output_2_layer[1]), .num3(output_2_layer[2]),
                .ps(output_3_layer[0]), .pc(output_3_layer[1]));

wire [DATA_WIDTH - 1:0] output_4_layer [1:0];
csa #(DATA_WIDTH)csa_4_layer(.num1(output_3_layer[0]), .num2(output_3_layer[1]), .num3(output_2_layer[3]),
                .ps(output_4_layer[0]), .pc(output_4_layer[1]));

wire [DATA_WIDTH - 1:0] output_5_layer [1:0];
csa #(DATA_WIDTH)csa_5_layer(.num1(output_4_layer[0]), .num2(output_4_layer[1]), .num3(output_1_layer[6]),
                .ps(output_5_layer[0]), .pc(output_5_layer[1]));

wire [DATA_WIDTH - 1:0] output_6_layer [1:0];
csa #(DATA_WIDTH)csa_6_layer(.num1(output_5_layer[0]), .num2(output_5_layer[1]), .num3(output_1_layer[7]),
                .ps(output_6_layer[0]), .pc(output_6_layer[1]));

`define LSB ii * DATA_WIDTH
`define MSB ii * DATA_WIDTH + DATA_WIDTH - 1
generate
    genvar ii;
    for (ii = 0; ii < 2; ii = ii + 1) begin
        assign result[`MSB:`LSB] = output_6_layer[ii];
    end
endgenerate
`undef LSB
`undef MSB

endmodule