// Full Adder Module
module fa (input a, input b, input cin, output sum, output cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

// Inverter Module
module invert (output out, input in);
    assign out = ~in;
endmodule

// 8-bit Adder
module Adder (input [7:0] a, b, output [7:0] sum);
    wire [7:0] q;
    wire cout;

    fa fa1(a[0], b[0], 1'b0, sum[0], q[0]);
    fa fa2(a[1], b[1], q[0], sum[1], q[1]);
    fa fa3(a[2], b[2], q[1], sum[2], q[2]);
    fa fa4(a[3], b[3], q[2], sum[3], q[3]);
    fa fa5(a[4], b[4], q[3], sum[4], q[4]);
    fa fa6(a[5], b[5], q[4], sum[5], q[5]);
    fa fa7(a[6], b[6], q[5], sum[6], q[6]);
    fa fa8(a[7], b[7], q[6], sum[7], cout);
endmodule

// 8-bit Subtractor
module Subtractor (input [7:0] a, b, output [7:0] sum);
    wire [7:0] ib;
    wire [7:0] q;
    wire cout;

    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin
            invert inv(ib[i], b[i]);
        end
    endgenerate

    fa fa1(a[0], ib[0], 1'b1, sum[0], q[0]);
    fa fa2(a[1], ib[1], q[0], sum[1], q[1]);
    fa fa3(a[2], ib[2], q[1], sum[2], q[2]);
    fa fa4(a[3], ib[3], q[2], sum[3], q[3]);
    fa fa5(a[4], ib[4], q[3], sum[4], q[4]);
    fa fa6(a[5], ib[5], q[4], sum[5], q[5]);
    fa fa7(a[6], ib[6], q[5], sum[6], q[6]);
    fa fa8(a[7], ib[7], q[6], sum[7], cout);
endmodule

// Booth Substep Module
module booth_substep (
    input wire signed [7:0] a, Q,
    input wire signed q0,
    input wire signed [7:0] m,
    output reg signed [7:0] f8, l8,
    output reg cq0
);
    wire [7:0] addam, subam;
    
    Adder myadd(a, m, addam);
    Subtractor mysub(a, m, subam);

    always @(*) begin
        if (Q[0] == q0) begin
            cq0 = Q[0];
            l8 = Q >> 1;
            l8[7] = a[0];
            f8 = a >> 1;
            f8[7] = a[7];
        end else if (Q[0] == 1 && q0 == 0) begin
            cq0 = Q[0];
            l8 = Q >> 1;
            l8[7] = subam[0];
            f8 = subam >> 1;
            f8[7] = subam[7];
        end else begin
            cq0 = Q[0];
            l8 = Q >> 1;
            l8[7] = addam[0];
            f8 = addam >> 1;
            f8[7] = addam[7];
        end
    end
endmodule

// Booth Multiplier Module
module booth_multiplier (input signed [7:0] a, b, output signed [15:0] c);
    wire signed [7:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7;
    wire signed [7:0] A0, A1, A2, A3, A4, A5, A6, A7;
    wire signed [7:0] q0;
    wire qout;

    booth_substep step1(8'b00000000, a, 1'b0, b, A1, Q1, q0[1]);
    booth_substep step2(A1, Q1, q0[1], b, A2, Q2, q0[2]);
    booth_substep step3(A2, Q2, q0[2], b, A3, Q3, q0[3]);
    booth_substep step4(A3, Q3, q0[3], b, A4, Q4, q0[4]);
    booth_substep step5(A4, Q4, q0[4], b, A5, Q5, q0[5]);
    booth_substep step6(A5, Q5, q0[5], b, A6, Q6, q0[6]);
    booth_substep step7(A6, Q6, q0[6], b, A7, Q7, q0[7]);
    booth_substep step8(A7, Q7, q0[7], b, c[15:8], c[7:0], qout);
endmodule

