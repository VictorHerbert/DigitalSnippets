module testbench;

    logic clk, reset, write, read, overflow;
    logic[3:0] write_addr;
    logic[3:0] read_addr;
    

    fifo_controller #(4) fifo_controller_0(
        clk, reset, 
        write, read,
        write_addr, read_addr,
        overflow
    );
  
    initial begin
        clk = 0;
        reset = 1; write = 0; read = 0;
        # 2 reset = 0;
        for(integer i = 0; i < 100; i++) begin
        	#10 clk = 0;
            #10 write = i%2==0;
                read = i%5==0;
                clk = 1;
        end
    end

    initial begin
        
    end  	

endmodule