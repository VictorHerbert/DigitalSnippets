module lcd_16x2_avalon(
    input clk, reset,
    input write,
    input address,
    input[7:0] write_data,

    output RS,
    output RW,
    output E,
    output[7:0] DATA
);

    assign E = write&clk;
    assign RS = ~address;
    assign DATA = write_data;
    assign RW = 0;

    /*
    
    reg rw;
    reg data_available = 0;
    reg write_done = 0;
    reg[7:0] data;    
    reg[7:0] data_output;
    reg[1:0] counter;

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            rw = 0;
            data = 0;
        end
        else begin
            if(write) begin
                rw <= ~address;
                data <= write_data;
            end
        end
    end*/

endmodule

/*
    always_ff @(posedge clk, posedge write_done, posedge reset) begin
        if(write_done|reset) begin
            data_available = 0;
        end
        else begin
            if(write) begin
                data_available <= 1;
            end
        end
    end

    always_ff @(posedge clk_slow, posedge write) begin
        if(write) begin
            write_done = 0;
            counter = 0;
        end
        else if(data_available) begin
            counter <= counter+1;
            
            if(counter == 1) begin
                write_done <= 1;
                data_output <= data;
            end
            else begin
                write_done <= 0;
            end
                
        end
    end
*/
/*
    rs <= '0';
    data <= x"38"; -- 8 bit / 2 lines
    data <= x"0E"; -- blinking-block cursor
    data <= x"80"; -- cursor to 0,0
    data <= x"01"; -- clear display
    state <= data0;
    rs <= '0';
*/