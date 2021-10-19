module RippleAdder #(parameter SIZE)(
    input[SIZE-1:0] a,
    input[SIZE-1:0] b,
    input carry_in,

    output[SIZE-1:0] c,
    output carry_out,
    output overflow
);

wire[SIZE-1:0] _carry_in;
wire[SIZE-1:0] _carry_out;

assign _carry_in[0] = carry_in;
assign carry_out = carry_out;

assign overflow = (~(a[7]^b[7]))^c[7];

generate
    genvar i;
    for(i = 1; i < SIZE; i++) begin : carry_gen
        assign _carry_in[i] = _carry_out[i-1];
    end

    for(i = 0; i < SIZE; i++) begin : full_adder_gen
        FullAdder full_adder(
            a[i], b[i], _carry_in[i],
            c[i], _carry_out[i]
        );
    end
endgenerate;

endmodule