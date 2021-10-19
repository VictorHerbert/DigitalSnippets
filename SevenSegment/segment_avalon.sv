module segment_avalon(
    input clk, reset,
    input write, read,
    input[15:0] write_data,
    output[15:0] read_data,


    output[3:0] digits,
    output[6:0] segments
);

    reg[15:0] data;

    reg[3:0] enable = 4'b1110;
    logic[3:0] bcd_out;

    assign digits = enable;

    always_ff @(posedge clk) begin : display_enable_select
        enable <= {enable[2:0], enable[3]};
    end

    wire[3:0][3:0] numbers;


    always_comb
    case(enable)
        4'b1110: bcd_out = numbers[3];
        4'b1101: bcd_out = numbers[2];
        4'b1011: bcd_out = numbers[1];
        4'b0111: bcd_out = numbers[0];
        default bcd_out = 4'b0000;
    endcase

    
    double_dabble #(13, 4) double_dabble_i0(
        clk, reset,
        write,
        write_data[12:0], numbers
    );

    /*always_ff @(posedge clk, posedge reset) begin
        if(reset)
            data <= 0;
        else if(write)
            data <= write_data;
    end
    
    assign read_data = data;    

    always_comb
        case(enable)
            4'b1110: bcd_out = data[15:12];
            4'b1101: bcd_out = data[11:8];
            4'b1011: bcd_out = data[7:4];
            4'b0111: bcd_out = data[3:0];
            default bcd_out = 4'b0000;
        endcase
    */

    segment_decoder segment_decoder_i0(
        bcd_out, segments
    );

endmodule