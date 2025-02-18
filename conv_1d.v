module conv_1d #(
    parameter N = 5,
    parameter M = 3  
)(
    input clk, rst,
    input [7:0] a, b,
    output reg [7:0] out,
    output reg done
);

localparam s_init=7, s0=0, s1=1, s2=2, s3=3, s4=4, s5=5 , s6=6;
reg [2:0] state, next_state;
reg [7:0] A[0:N-1];//creating array to store i/p
reg [7:0] B[0:M-1];   
reg [7:0] Y[0:N+M-2];//creating array to stroe o/p

integer i, n, t, k,s,j;

always @(posedge clk) 
    begin
        if (rst) 
            state <= s_init; 
        else
            state <= next_state;
    end
    
//process block
always@(posedge clk) 
    begin
        case(state)
        s_init:
             begin
            i <= 0;
            n <= 0;
            j <= 0;
            k <= 0;
            t <= 0;
            done <= 0;
            out <= 8'b0;
            for ( s = 0; s < N+M-1; s = s +1)
                Y[s] <= 8'b0; 
            end
        s0:
             begin
            if(i<M) begin
            A[i] <= a;
            B[i]<=b;
            end
            else if(M<i<N)
            A[i] <= a;
            end
        s1:
            begin
                i<=i+1;
            end
        s2:
            begin
                if (k <= n) 
                    begin 
                    if(k < N && (n - k) < M)
                        Y[n] <= A[k] * B[n - k] + Y[n];
                    end
           end
       s3:
            k<=k+1;
        s4:
            begin
                k<=0;
                out<=Y[n];
            end
            
        s5: 
              n<=n+1;
        s6: begin
                done<=1;
            end
        endcase 
      end


always @(*) begin
    case (state)
        s_init: 
        next_state=s0;

        s0: begin
            if (i < N) 
                begin
                    next_state = s1;
                end 
            else 
                begin
                    next_state = s2;
                end
            end
        s1: 
                next_state=s0;
        s2: 
            begin
                if (k <= n) 
                    begin 
                        next_state=s3;
                    end
            
                else 
                    next_state=s4;
            end
        s3: 
                next_state=s2;
        s4:
            begin 
                if(n < N+M-1)
                    next_state=s5;
                else
                    next_state=s6;
                
            end
        s5: 
            next_state=s2;
            
        s6: 
            next_state=s6;
    endcase
end
endmodule
