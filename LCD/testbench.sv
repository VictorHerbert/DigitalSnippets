`timescale 1s/1ns  

module testbench;
    parameter CLK_FREQ = 50e6;
    parameter CLK_PERIOD = 1/CLK_FREQ;
    parameter CLK_HALF_PERIOD = CLK_PERIOD/2;

    logic clk, reset;
    logic write;
    logic address;
    logic[7:0] write_data;

    logic clk_slow;

    logic RS;
    logic RW;
    logic E;
    logic[7:0] DATA;

    lcd_16x2_avalon lcd_16x2_avalon(
        clk, reset,
        write,
        address,
        write_data,

        clk_slow,

        RS,
        RW,
        E,
        DATA
    );
    initial begin
        reset = 1;
        #CLK_PERIOD;
        reset = 0;
    end
    initial begin
        write_data = 0;
        address = 1;
        for(int i = 0; i < 1000; i++) begin
            clk = 1;
            if(i%80 == 2) begin
                write = 1;
                write_data = $random(); 
            end
            else begin
                write = 0;
            end

        	#CLK_HALF_PERIOD;
            clk = 0;
            #CLK_HALF_PERIOD; 
        end

        #(5*CLK_PERIOD);
    end
    initial begin
        for(int i = 0; i < 50; i++) begin
            clk_slow = 1;
        	#(20*CLK_HALF_PERIOD);
            clk_slow = 0;
            #(20*CLK_HALF_PERIOD); 
        end

        #(5*CLK_PERIOD);
    end
    initial begin
        /*write = 0;
        #CLK_PERIOD;
        write = 1;
        #CLK_PERIOD;
        write = 0;*/
    end

endmodule