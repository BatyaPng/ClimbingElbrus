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
reg [CAPACITY] head;
reg [CAPACITY] tail;
// reg state_system;
wire state_system;

always @(posedge clk) begin
    $display("rd_val   - %d; wr_ready - %d", rd_val, wr_ready);
    $display("rd_en    - %d; wr_en    - %d", rd_en, wr_en);
    $display("counter %d", counter);
    if (reset) begin
        head <= 0;
        tail <= 0;
        $display("I'm here 22");    
    end
    else if (rd_en & rd_val) begin
        $display("Out[%d] %d", head, queue[head],);
        rd_data <= queue[head];
        head <= head + 1; 
    end
    else if (wr_en & wr_ready) begin
        $display("In[%d] %d", tail, wr_data);
        queue[tail + 1] <= wr_data;
        tail <= tail + 1;
    end
end

// always @(posedge clk) begin
//     if (reset) begin
//         state_system <= 1;
//     end
//     else if (tail < head) begin
//         state_system <= 0;
//     end
// end

assign state_system = (tail < head) ? 0 : 1;

assign rd_val = (~((tail > head) ^ state_system)) ? 1 : 0;
assign wr_ready = ((tail - head != FIFO_DEPTH - 1) & (tail - head != 1) ? 1 : 0;
    
endmodule