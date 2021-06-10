module testbench;

    logic clk, write;
    logic[7:0] data;
    logic[3:0][3:0] digits;
    

    double_dabble #(8, 4) double_dabble_inst(
        clk, write,
        data, digits
    );
  
    initial begin
        clk = 0;
        for(integer i = 0; i < 100; i++)
        	#10 clk = ~clk;
        #10;
    end

    initial begin
        for(int i = 0; i < 4; i++) begin
            data = $random;
            #5 write = 1;
            #5 write = 0;
            #160;
        end
    end  	

endmodule