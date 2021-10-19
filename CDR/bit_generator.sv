//Pseudo random number generator
module bit_generator #(parameter SIZE, parameter[SIZE-1:0] SEED)(
    input clk, reset,
    output serial_out
);

    reg[SIZE-1:0] data = {SIZE{1'b1}};
    wire[SIZE-1:0] xor_out;

        
    generate 
	genvar i; 
        for(i = 1; i < SIZE; i++) begin : xor_gen
            if(SEED[i] == 1'b1)
                assign xor_out[i] = data[i-1]^data[SIZE-1];
            else
                assign xor_out[i] = data[i-1];
        end
        if(SEED[0] == 1'b1)
            assign xor_out[0] = ~data[SIZE-1];
        else
            assign xor_out[0] = data[SIZE-1];
        
    endgenerate


    always_ff @(posedge clk, posedge reset) begin
        if(reset)
            data <= {SIZE{1'b1}};
        else
            data <= xor_out;
    end

    assign serial_out = data[SIZE-1];

endmodule