module fifo_controller #(parameter DEPTH = 8)(
    input clk, reset, 
    input write_e, read_e,
    output[DEPTH-1:0] write_addr, 
    output[DEPTH-1:0] read_addr,
    input overflow
);

    reg[DEPTH-1:0] _write_addr;
    reg[DEPTH-1:0] _read_addr;
    assign write_addr = _write_addr;
    assign read_addr = _read_addr;

    wire[DEPTH-1:0] _read_addr_1 = _read_addr+1;
    wire[DEPTH-1:0] _write_addr_1 = _write_addr+1;

    wire empty = (_read_addr_1 == _write_addr);
    wire full = (_write_addr_1 == _read_addr);

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            _write_addr = 1;
            _read_addr = 0;
        end
        else begin
            if(write_e & ~full) begin
                _write_addr <= _write_addr_1;
            end
            if(read_e & ~empty) begin
                _read_addr <= _read_addr_1;
            end
        end
    end



endmodule