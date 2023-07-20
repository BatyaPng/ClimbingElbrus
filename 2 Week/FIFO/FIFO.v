module fifo
#(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 1,
    parameter CAPACITY = $clog2(FIFO_DEPTH)
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
        $display("I'm here 22");    
    end
    else if (rd_en & rd_val) begin
        $display("Out %d", queue[counter]);
        rd_data <= queue[counter];
        counter <= counter - 1; 
    end
    else if (wr_en & wr_ready) begin
        $display("In %d", wr_data);
        $display("Var: rd_val   - %d; wr_ready - %d", rd_val, wr_ready);
        $display("Var: rd_en    - %d; wr_en    - %d", rd_en, wr_en);
        queue[counter + 1] <= wr_data;
        counter <= counter + 1;
    end
end

assign rd_val = (counter != 0) ? 1 : 0;
assign wr_ready = (counter < FIFO_DEPTH) ? 1 : 0;
    
endmodule