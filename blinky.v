module top(input clk_25mhz,
           inout [27:0] gp,
           output [7:0] led);

    wire rioc;
    assign rioc= gp[12];
    assign gp[13] = 1;

    always @(posedge clk_25mhz) begin
          led[6:0] <= 0;
          led[7] <= rioc;
    end

endmodule