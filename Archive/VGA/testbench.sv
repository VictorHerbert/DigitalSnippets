module testbench;
    logic clk_in;
    logic clk_out;
    logic[24:0] r,g,b;
    logic h_sync,v_sync;

    vga vga0(
        .clk_in(clk_in),
        .clk_out(clk_out),
        .r(r),.g(g),.b(b),
        .h_sync(h_sync), .v_sync(v_sync)
    );
  
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        
        clk_in = 0;
        for(integer i = 0; i < 30000; i++)
        	#5 clk_in = ~clk_in;
    end


endmodule