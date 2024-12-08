module top(input clk_25mhz,
           inout [27:0] gp,
           inout [27:0] gn,
           output [7:0] led);

    assign gp[12] = 1;

    always @(posedge clk_25mhz) begin
          led[6:0] <= 0;
          led[7] <= gn[12];
    end

endmodule