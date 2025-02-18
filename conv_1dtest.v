module conv1d_test;
   // parameter N = 5;
    //parameter M = 5;
    
    reg clk, rst;
    reg [7:0] a, b;
    wire [7:0] out;
    wire done;
    
    // Instantiate the convolution module
    conv_1d #(5,3) uut (
        .clk(clk), 
        .rst(rst), 
        .a(a), 
        .b(b), 
        .out(out), 
        .done(done)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns clock period
    
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        #100;
        
        
        
        rst = 0; // Deassert reset after some time
        
        // Apply inputs sequentially with proper timing
        #3 a = 8'd1; b = 8'd1;
        #20 a = 8'd2; b = 8'd2;
        #20 a = 8'd3; b = 8'd3;
        #20 a = 8'd4; 
        #20 a = 8'd5; 
        

    end
    
endmodule
