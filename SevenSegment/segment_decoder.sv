module segment_decoder(
    input[3:0] bcd,
    output[6:0] segment
);
    always_comb
    case(bcd)
        4'd0: segment = 7'b0000001; // "0"  
        4'd1: segment = 7'b1001111; // "1" 
        4'd2: segment = 7'b0010010; // "2" 
        4'd3: segment = 7'b0000110; // "3" 
        4'd4: segment = 7'b1001100; // "4" 
        4'd5: segment = 7'b0100100; // "5" 
        4'd6: segment = 7'b0100000; // "6" 
        4'd7: segment = 7'b0001111; // "7" 
        4'd8: segment = 7'b0000000; // "8"  
        4'd9: segment = 7'b0000100; // "9" 
        4'd10: segment = 7'b0001000; // "10" 
        4'd11: segment = 7'b1100000; // "11" 
        4'd12: segment = 7'b0110001; // "12" 
        4'd13: segment = 7'b1000010; // "13"  
        4'd14: segment = 7'b0110000; // "14" 
        4'd15: segment = 7'b0111000; // "15" 
    endcase

endmodule