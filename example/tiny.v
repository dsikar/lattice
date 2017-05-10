// tiny.v
// fpga demo for icepick lattice ice40hx1k
// jcl/othinking/2017-02-10

module top(input clk,
    output x0,
    output x1,
    output x2,
    output x3,
    output green);
    reg [23:0] counter;
   
    always @(posedge clk) begin
        counter <= counter + 1;
    end
   
    assign x3 = counter[23];
    assign x2 = counter[22];
    assign x1 = counter[21];
    assign x0 = counter[20];
    assign green = 1;
endmodule

// end
