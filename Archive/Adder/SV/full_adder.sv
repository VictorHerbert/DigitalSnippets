module FullAdder (
    input a, b, carry_in,
    output c, carry_out
);

wire a_xor_b =a^b;

assign c = a_xor_b^carry_in;
assign carry_out = (a&b)|(a_xor_b&carry_in);
    
endmodule