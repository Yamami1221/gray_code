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

    xor (out[0], in[0], in[1]);
    and (out[1], in[0], in[1]);
endmodule

module counter(q, clk, res);
    output [1:0]q;
    input clk, res;

    wire new_clk;
    clock_reduce cr(new_clk, clk, res);
    T_FF t0(q[0], 1'b1, new_clk, res);
    T_FF t1(q[1], q[0], new_clk, res);
endmodule

module clock_reduce(clk_out, clk_in, reset);
    input clk_in, reset;
    wire [18:0]counters;
    output clk_out;

    T_FF t0(counters[0], 1'b1, clk_in, reset);
    T_FF t1(counters[1], 1'b1, counters[0], reset);
    T_FF t2(counters[2], 1'b1, counters[1], reset);
    T_FF t3(counters[3], 1'b1, counters[2], reset);
    T_FF t4(counters[4], 1'b1, counters[3], reset);
    T_FF t5(counters[5], 1'b1, counters[4], reset);
    T_FF t6(counters[6], 1'b1, counters[5], reset);
    T_FF t7(counters[7], 1'b1, counters[6], reset);
    T_FF t8(counters[8], 1'b1, counters[7], reset);
    T_FF t9(counters[9], 1'b1, counters[8], reset);
    T_FF t10(counters[10], 1'b1, counters[9], reset);
    T_FF t11(counters[11], 1'b1, counters[10], reset);
    T_FF t12(counters[12], 1'b1, counters[11], reset);
    T_FF t13(counters[13], 1'b1, counters[12], reset);
    T_FF t14(counters[14], 1'b1, counters[13], reset);
    T_FF t15(counters[15], 1'b1, counters[14], reset);
    T_FF t16(counters[16], 1'b1, counters[15], reset);
    T_FF t17(counters[17], 1'b1, counters[16], reset);
    T_FF t18(counters[18], 1'b1, counters[17], reset);
    T_FF t19(clk_out, 1'b1, counters[18], reset);
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