module ps2_keyboard(
    input ps2_clk, ps2_data,
    output[7:0] data
);
    enum {IDLE, SHIFT, GRAB} state = IDLE;

    reg[4:0] counter = 0;
    reg[8:0] data_reg = 0;
    reg parity_check = 0;

    reg[7:0] _data;
    assign data = _data;


    always_ff @(negedge ps2_clk) begin
        if(counter != 10) begin
            data_reg <= {data_reg[9:0], ps2_data};
            parity_check <= parity_check^ps2_data;

            counter <= counter + 1;
        end
        else begin
            if(parity_check)
                _data <= data_reg[8:1];

            parity_check <= 0;
            data_reg <= 0;
            counter <= 0;
        end
    end

endmodule