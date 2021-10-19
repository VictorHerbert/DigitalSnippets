module Serializer #(parameter SIZE = 32)(
    input clk, reset, write_enable,
    input[SIZE-1:0] data_in,
    output reg ready = 1,
    output serial_data_out
);
    reg[SIZE:0] data = 0;
    reg[$clog2(SIZE+1)-1:0] counter = 0;

    typedef enum {IDLE, GRAB, SHIFT} state;


    assign serial_data_out = data[$clog2(SIZE+1)-1];

    always_ff @(posedge clk, posedge reset) begin
        if(write_enable) begin
            data <= {1'b1, data_in};
            counter <= 0;
            ready <= 0;
        end
        else if(counter < SIZE-1) begin
            data <= {data[SIZE-1:0], 1'b0};
            counter <= counter+1;
        end
        else
            ready <= 1;
    end
        
endmodule;