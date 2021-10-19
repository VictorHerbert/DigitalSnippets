module testbench;

localparam CLK_PERIOD = 10;
localparam CLK_HALF_PERIOD = CLK_PERIOD/2;
localparam CYCLES_COUNT = 100;

logic clk;

logic[7:0] a,b,c;
logic carry_out;
logic overflow;

RippleAdder #(8) ripple_adder(
    .a(a), .b(b), .carry_in(1'b0),
    .c(c), .carry_out(carry_out), .overflow(overflow)
);

initial begin
    clk = 0;
    repeat(CYCLES_COUNT) #CLK_HALF_PERIOD clk = ~clk;
end

initial begin
    a = 0; b = 0;
    for(integer i = 0; i < CYCLES_COUNT; i++) begin
        #CLK_PERIOD 
        a = $random();
        b = $random();
    end
end

endmodule