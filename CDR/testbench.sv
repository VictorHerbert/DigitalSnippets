`timescale 1s/1ns  

module testbench;
    parameter CLK_FREQ = 3e3;
    parameter CLK_PERIOD = 1/CLK_FREQ;
    parameter CLK_HALF_PERIOD = CLK_PERIOD/2;
    parameter CLK_QUAD_PERIOD = CLK_PERIOD/4;

    parameter OVERSAMPLING_FACTOR = 2*2;

    parameter DATA_CLK_PHASE = 0.1*CLK_PERIOD;
    parameter DATA_CLK_STRECH = 0.95;



    logic clk = 0, clk_90 = 0;
    logic reset;
    logic data_in = 0, data_out, data_out_check;

    cdr cdr(
        clk, clk_90,
        data_in,
        clk_out, data_out
    );


        
    initial begin
        for(int i = 0; i < 1000; i++)
            #CLK_HALF_PERIOD clk = ~clk;
    end
    initial begin
        #CLK_QUAD_PERIOD;
        for(int i = 0; i < 1000; i++)
            #CLK_HALF_PERIOD clk_90 = ~clk_90;
    end
    initial begin
        #DATA_CLK_PHASE

        for(int i = 0; i < 50; i++)
            #(CLK_PERIOD*DATA_CLK_STRECH) data_in = ~data_in;
    end

endmodule