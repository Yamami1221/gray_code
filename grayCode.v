module grayCode(out, clk, res);
    output [1:0]out;
    input clk, res;
    wire [1:0]q;

    counter c(q, clk, res);
    gray_encoder g(out, q);
endmodule

module gray_encoder(out, in);
    output [1:0]out;
    input [1:0]in;

    and (out[0], in[0], in[1]);
    xor (out[1], in[0], in[1]);
endmodule

module counter(q, clk, res);
    output [1:0]q;
    input clk, res;

    T_FF t0(q[0], 1'b1, clk, res);
    T_FF t1(q[1], q[0], clk, res);
endmodule

module T_FF(q, t, clk, res);
    output q;
    input t, clk, res;
    wire d;

    xor (d, q, t);
    D_FF dff(q, d, clk, res);
endmodule

module D_FF(q, d, clk, res);
    output q;
    input d, clk, res;
    reg q;
    always @(posedge res or negedge clk) begin
        if (res == 1'b1) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule

00  00
01  01
10  11
11  10