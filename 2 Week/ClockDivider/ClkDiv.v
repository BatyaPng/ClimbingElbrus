module clk_div_2n
#(
    parameter div = 2,
    parameter capacity = $clog2(div)
)
(
    input clk, reset,

    output reg clk_div
);

reg [capacity + 1]counter = 1;

initial clk_div = 1;

always @(posedge clk) begin
    counter += 1;

    if (reset) begin
        $display("I'm here 20");
        counter <= 1;
        clk_div <= 0;
    end
    else if (counter == div) begin
        counter <= 1;
        clk_div <= ~clk_div;
    end
end

endmodule
