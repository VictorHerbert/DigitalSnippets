module cdr (
    input clk, clk_90,
    input data_in,

    output reg clk_out = 0,
    output reg data_out
);

    reg[3:0] a,b,c,d;
    
    wire ax = a[3]^a[2];
    wire bx = b[3]^b[2];
    wire cx = c[3]^c[2];
    wire dx = d[3]^d[2];

    always_ff @(posedge clk) begin
        a <= {a[2:0], data_in};
        b[3:1] <= b[2:0];
        c[3:2] <= b[2:1];
        d[3] <= d[2];
    end
    always_ff @(posedge clk_90) begin
        b[0] <= data_in;
        c[1] <= c[0];
        d[2] <= d[1];
    end
    always_ff @(negedge clk) begin
        c[0] <= data_in;
        d[1] <= d[0];
    end
    always_ff @(negedge clk_90) begin
        d[0] <= data_in;
    end


endmodule