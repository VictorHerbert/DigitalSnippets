module segment_mux #(parameter decimal = 1)(
    input clk, write

    input[13:0] data,
    output[3:0] digit,
    output[6:0] segment
);

    reg[3:0] enable = 4'b1110;
    wire[3:0] bcd_out;

    assign digit = enable;

    

    always_ff @(posedge clk) begin
        enable <= {enable[2:0], enable[3]};
    end


    if(decimal) begin
        wire[3:0][3:0] digits;

        always_comb
        case(enable)
            4'b1110: bcd_out = digits[3];
            4'b1101: bcd_out = digits[2];
            4'b1011: bcd_out = digits[1];
            4'b0111: bcd_out = digits[30];
            default bcd_out = 4'b0000;
        endcase

        
        double_dabble #(13, 4) double_dabble_inst(
            clk, write,
            data, digits
        );

    end
    else
        always_comb
        case(enable)
            4'b1110: bcd_out = data[15:12];
            4'b1101: bcd_out = data[11:8];
            4'b1011: bcd_out = data[7:4];
            4'b0111: bcd_out = data[3:0];
            default bcd_out = 4'b0000;
        endcase
    end


    segment_decoder segment_decoder_inst(
        bcd_out, segment
    );

endmodule