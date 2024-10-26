module top(input clk_25mhz, 
           input [6:0] btn, 
           output [7:0] led);

    assign led[6:0] = 0;

    always @(posedge clk_25mhz) begin
          led[7] <= btn[1];
    end

endmodule