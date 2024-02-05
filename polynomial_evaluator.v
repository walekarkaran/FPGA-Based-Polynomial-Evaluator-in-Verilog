module polynomial_evaluator(
    input wire clk,
    input wire reset,
    input wire start_eval,
    input wire [3:0] n
);
    reg [7:0] counter;
    reg [15:0] x_to_m;
    reg [15:0] coef_m;
    reg [31:0] acc;
    reg [7:0] evaluation_done;
    reg [15:0] coef [0:7];
    reg [15:0] x;
    integer i=0;
    integer t=0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
        
            evaluation_done = 8'b0;
            counter = 8'b0;
            x_to_m = 16'b1;
            coef_m = 32'b0;
            acc = 32'b0;
        end 
        else if (start_eval && evaluation_done == 8'b0) begin
                t = counter;
                coef_m = coef[t];
                for(i=0;i<counter;i=i+1)begin
                x_to_m = x_to_m * x;
                end
                acc = acc + coef_m * x_to_m;
                counter = counter + 1;
                
                if (counter > n) begin
                evaluation_done = 8'b1;
                end
        end
            
        
    end
endmodule