`timescale 1ns/1ps

module testbench;
    parameter CLK_PERIOD = 10;
    parameter CLK_HALF_PERIOD = CLK_PERIOD/2;

    reg clk, reset, write_enable;
    reg[31:0] data_in;
    reg ready;
    reg serial_data_out;
    
    Serializer #(32) serializer_i0(
        clk, reset, write_enable,
        data_in,
        ready,
        serial_data_out
    );
  
    initial begin
        clk = 0;
        reset = 0;
        for(int i = 0; i < 100; i++)
            #CLK_HALF_PERIOD clk = ~clk;
    end
    initial begin
        write_enable = 0;
        data_in = $random();
        #CLK_PERIOD;

        for(int i = 0; i < 100; i++) begin
            #CLK_PERIOD;
            write_enable <= (i == 4);
            data_in <= $random();
        end
    end

endmodule