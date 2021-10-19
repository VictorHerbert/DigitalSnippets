module clk_div #(parameter IN_FREQ = 50_000_000, parameter OUT_FREQ = 5_000)(
    input clk_in,
    output clk_out
);
    parameter COUNTER_THR = IN_FREQ/(2*OUT_FREQ)-1;

    reg[$clog2(COUNTER_THR):0] counter = 0;
    reg _clk_out = 0;

    assign clk_out = _clk_out;

    always_ff @( posedge clk_in ) begin
        if(counter < COUNTER_THR)
            counter <= counter + 1;
        else begin
            counter <= 0;
            _clk_out <= ~_clk_out;
        end
    end

endmodule