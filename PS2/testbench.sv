`timescale 1s/1ns  

module testbench;
    parameter CLK_FREQ = 10e3;
    parameter CLK_PERIOD = 1/CLK_FREQ;
    parameter CLK_HALF_PERIOD = CLK_PERIOD/2;

    logic ps2_clk, ps2_data;
    logic[0:10] ps2_data_parallel = {1'b0, 8'hA2, 2'b11};
    logic[7:0] data;

    ps2_keyboard ps2_keyboard_i0(
        ps2_clk, ps2_data,
        data
    );
  
    initial begin
        ps2_clk = 1; ps2_data = 1;
        #(5*CLK_PERIOD);

        for(int i = 0; i < 11; i++) begin
            ps2_data = ps2_data_parallel[i];
            ps2_clk = 1;
        	#CLK_HALF_PERIOD;
            ps2_clk = 0;
            #CLK_HALF_PERIOD; 
        end

        #(5*CLK_PERIOD);

    end 	

endmodule