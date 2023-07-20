module fifo
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
    $display("rd_val   - %d; wr_ready - %d", rd_val, wr_ready);
    $display("rd_en    - %d; wr_en    - %d", rd_en, wr_en);
    $display("counter %d", counter);
    if (reset) begin
        counter <= 0;
        $display("I'm here 22");    
    end
    else if (rd_en & rd_val) begin
        $display("Out[%d] %d", counter - 1, queue[counter - 1],);
        rd_data <= queue[counter - 1];
        counter <= counter - 1; 
    end
    else if (wr_en & wr_ready) begin
        $display("In[%d] %d", counter, wr_data);
        queue[counter] <= wr_data;
        counter <= counter + 1;
    end
end

assign rd_val = (counter != 0) ? 1 : 0;
assign wr_ready = (counter < FIFO_DEPTH) ? 1 : 0;
    
endmodule