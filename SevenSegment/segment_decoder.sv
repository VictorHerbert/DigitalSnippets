module segment_decoder(
    input[3:0] bcd,
    output[6:0] segment
);

    reg[6:0] _segment;
    assign segment = _segment;

    always_comb
    case(bcd)
        4'd0:   _segment = 7'b0000001; // "0"  
        4'd1:   _segment = 7'b1001111; // "1" 
        4'd2:   _segment = 7'b0010010; // "2" 
        4'd3:   _segment = 7'b0000110; // "3" 
        4'd4:   _segment = 7'b1001100; // "4" 
        4'd5:   _segment = 7'b0100100; // "5" 
        4'd6:   _segment = 7'b0100000; // "6" 
        4'd7:   _segment = 7'b0001111; // "7" 
        4'd8:   _segment = 7'b0000000; // "8"  
        4'd9:   _segment = 7'b0000100; // "9" 
        4'd10:  _segment = 7'b0001000; // "10" 
        4'd11:  _segment = 7'b1100000; // "11" 
        4'd12:  _segment = 7'b0110001; // "12" 
        4'd13:  _segment = 7'b1000010; // "13"  
        4'd14:  _segment = 7'b0110000; // "14" 
        4'd15:  _segment = 7'b0111000; // "15" 
    endcase

endmodule