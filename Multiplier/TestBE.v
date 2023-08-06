`define DATA_WIDTH 6,
`define NUM_TERMS $ceil((DATA_WIDTH + 3) / 3),
`define CAPACITY_RESULT (DATA_WIDTH * 2 - 1) * NUM_TERMS
module top();

reg clk = 0;

reg [5:0] A;
reg [5:0] B;
wire [32:0] result;

booth_encoder #(6) booth_encoder_inst(.multiplicand(A),
                                              .multiplier(B),
                                              .result(result));

initial begin
    A <= 6'b110101;
    B <= 6'b011011;
end

always begin
    #1 clk = ~clk;
end

initial begin
    $dumpvars;

    #10;

    $finish;
end

endmodule