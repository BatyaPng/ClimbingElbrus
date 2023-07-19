module clk_div_2n
#(
    parameter div = 2,
    parameter capacity = $clog2(div)
)
(
    input clk, reset,

    output reg clk_div
);

reg [capacity + 1]counter;

always @(posedge clk) begin
    counter <= counter + 1;

    if (reset) begin
        counter <= 1;
        clk_div <= 0;
    end
    else if (counter == div) begin
        counter <= 1;
        clk_div <= ~clk_div;
    end
end

endmodule