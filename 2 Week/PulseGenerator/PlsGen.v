module pls_gen_n
#(
    parameter period = 2
)
(
    input clk, reset,

    output impulse
);

reg [period - 1]counter;

always @(posedge clk) begin
    if (reset)
        counter <= 0;
    else
        counter <= (counter < period - 1) ? counter + 1 : 0;
end

assign impulse = (counter == period - 1);

endmodule