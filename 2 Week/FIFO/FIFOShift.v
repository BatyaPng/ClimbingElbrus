module fifo_shift
#(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 1,
    parameter CAPACITY = $clog2(FIFO_DEPTH) + 1
)
(
    input clk, reset,
    input rd_en, wr_en,
    input [DATA_WIDTH] wr_data,

    output rd_val, wr_ready,
    output reg [DATA_WIDTH] rd_data
);

reg [DATA_WIDTH] queue [FIFO_DEPTH];

reg [CAPACITY] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 0;
    end else if (rd_en & rd_val) begin
        rd_data <= queue[0];
        counter <= counter - 1;
    end else if (wr_en & wr_ready) begin
        queue[counter - 1] <= wr_data;
        counter <= counter + 1;
    end

end

genvar i;
generate 
for (i = 0; i < FIFO_DEPTH - 1; i = i + 1) begin
    always @(posedge clk ) begin
        if (rd_en & rd_val) begin
            queue[i] <= queue[i + 1];        
        end
    end
end
endgenerate

assign rd_val = (counter != 0);
assign wr_ready = (counter < FIFO_DEPTH);

endmodule