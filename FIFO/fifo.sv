module fifo #(parameter SIZE = 8; parameter DEPTH = 4)(
    input clk, reset, 
    input write_e, read_e,
    output[DEPTH-1:0] write_addr, 
    output[DEPTH-1:0] read_addr,
    input overflow
);

    fifo_controller #(DEPTH = 8) fifo_controller_inst(
        clk, reset, 
        write_e, read_e,
        write_addr, read_addr,
        overflow
    );



endmodule;