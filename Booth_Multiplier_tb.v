// Testbench for Booth Multiplier
`timescale 1ns / 1ps

module booth_multiplier_tb;
    reg signed [7:0] a, b;
    wire signed [15:0] c;

    // Instantiate Booth Multiplier
    booth_multiplier uut (.a(a), .b(b), .c(c));

    initial begin
        // Test Case 1: Positive * Positive
        a = 8'd15; b = 8'd3;
        #10;
        $display("%d * %d = %d", a, b, c);

        // Test Case 2: Positive * Negative
        a = 8'd12; b = -8'd5;
        #10;
        $display("%d * %d = %d", a, b, c);

        // Test Case 3: Negative * Positive
        a = -8'd8; b = 8'd6;
        #10;
        $display("%d * %d = %d", a, b, c);

        // Test Case 4: Negative * Negative
        a = -8'd7; b = -8'd9;
        #10;
        $display("%d * %d = %d", a, b, c);

        // Test Case 5: Zero Multiplication
        a = 8'd0; b = 8'd25;
        #10;
        $display("%d * %d = %d", a, b, c);

        // Test Case 6: Large Numbers
        a = 8'd127; b = -8'd128;
        #10;
        $display("%d * %d = %d", a, b, c);

        $stop;
    end
endmodule
