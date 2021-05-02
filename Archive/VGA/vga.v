module vga(
    input clk_in,
    output clk_out,
    output[24:0] r,g,b,
    output logic h_sync,v_sync
);
    parameter
        h_front_porch = 100,
        h_sync_pulse = 200,
        h_back_porch = 400,
        h_line = 1000;
    parameter
        v_front_porch = 100,
        v_sync_pulse = 200,
        v_back_porch = 400,
        v_frame = 1000;

    logic[11:0] x=0,y=0;
    logic clk_pixel;

    assign clk_pixel = clk_in;
    assign clk_out = clk_pixel;

    always @ (posedge(clk_pixel)) begin
        if(x == h_line) begin
            x = 0;
            
            if(y == v_frame) begin
                y = 0; 
            end
            else
                y = y+1;
        end
        else
            x = x+1;
    end

    always_comb begin
        if(x >= h_sync_pulse && x < h_back_porch)
            h_sync <= 0;
        else
            h_sync <= 1;
        if(y >= v_sync_pulse && y < v_back_porch)
            v_sync <= 0;
        else
            v_sync <= 1;
    end

    

endmodule