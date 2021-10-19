`timescale 1s/1ns  

module testbench;
    parameter CLK_FREQ = 50e6;
    parameter CLK_PERIOD = 1/CLK_FREQ;
    parameter CLK_HALF_PERIOD = CLK_PERIOD/2;

    //Avalon Signals
    logic clk, reset;
    logic write;
    logic address;
    logic[15:0] write_data;

    logic[3:0] digits;
    logic[6:0] segments;

    segment_avalon segment_avalon_i0(
        clk, reset,
        write,
        write_data,

        digits,
        segments
    );

    initial begin
        reset = 1;
        #CLK_PERIOD;
        reset = 0;
    end
    initial begin
        for(int i = 0; i < 1000; i++) begin
            clk = 1;
        	#CLK_HALF_PERIOD;
            clk = 0;
            #CLK_HALF_PERIOD; 
        end
        #(5*CLK_PERIOD);
    end
    initial begin
        write_data = 0;
        address = 1;

        #(0.1*CLK_PERIOD);
        for(int i = 0; i < 1000; i++) begin
            if(i%80 == 2) begin
                write = 1;
                write_data = $random()%4000;
            end
            else begin
                write = 0;
                write_data = 0;
            end

            #CLK_PERIOD; 
        end

        #(5*CLK_PERIOD);
    end

endmodule