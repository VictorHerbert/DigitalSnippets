module double_dabble #(parameter SIZE = 8, parameter DIGIT_COUNT = 4)(
    input clk,
    input write,
    input[SIZE-1:0] data,
    output[DIGIT_COUNT-1:0][3:0] digits
);
    
    reg[SIZE-2:0] data_buffer;
    
    reg[4*DIGIT_COUNT-1:0] shift_reg;
    wire[4*DIGIT_COUNT-1:0] add_reg;

    reg [$clog2(SIZE)-1:0] counter;
    wire counter_finish = (counter == SIZE-2);

    reg[DIGIT_COUNT-1:0][3:0] _digits;
    assign digits = _digits;

    genvar i;
    for(i = 0; i < DIGIT_COUNT; i++) begin
        assign add_reg[(i+1)*4-1:i*4] = (
            (shift_reg[(i+1)*4-1:i*4] > 4) ?
                (shift_reg[(i+1)*4-1:i*4]+3) : shift_reg[(i+1)*4-1:i*4]
            );

        always_ff @(posedge counter_finish) begin 
            _digits[i] <= shift_reg[(i+1)*4-1:i*4];
        end
    end
        
    always_ff @(posedge clk, posedge write) begin
        if(write) begin
            data_buffer = data[SIZE-3:0];
            shift_reg = data[SIZE-1:SIZE-2];
            counter = 0;
        end
        else begin
            if(counter < SIZE-1) begin
                data_buffer <= {data_buffer[SIZE-3:0], 1'b0};
                shift_reg <= {add_reg[4*DIGIT_COUNT-2:0], data_buffer[SIZE-3]};
                counter <= counter+1;
            end
        end
    end

endmodule