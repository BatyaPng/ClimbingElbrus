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
reg [CAPACITY] counter;

always @(posedge clk) begin
    if (reset) begin
        head <= 0;
        tail <= 0;
        counter <= 0;
    end
    else if (rd_en & rd_val) begin
        rd_data <= queue[head];
        
        if (head == FIFO_DEPTH - 1) begin
            head <= 0;
        end
        else begin
            head <= head + 1;            
        end

        counter <= counter - 1; 
    end
    else if (wr_en & wr_ready) begin
        queue[tail] <= wr_data;

        if (tail == FIFO_DEPTH - 1) begin
            tail <= 0;
        end
        else begin
            tail <= tail + 1;            
        end

        counter <= counter + 1;
    end
end

assign rd_val = (counter != 0);
assign wr_ready = (counter < FIFO_DEPTH);
    
endmodule