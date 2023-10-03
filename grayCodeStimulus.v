module grayCodeStimulus;
    reg clk, res;
    wire [1:0]out;

    grayCode g(out, clk, res);
    initial begin
        $dumpfile("grayCode.vcd");
        $dumpvars(0, grayCodeStimulus);
        clk = 1'b0;
    end
    always #5 clk = ~clk;
    initial #100 $finish;
    initial begin
        res = 1'b1;
        #10 res = 1'b0;
        #50 res = 1'b1;
        #10 res = 1'b0;
    end
    initial $monitor("out=%b", out);
endmodule