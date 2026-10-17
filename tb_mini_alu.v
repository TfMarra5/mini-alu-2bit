`timescale 1ns/1ps
module tb_mini_alu #(
    parameter integer WIDTH = 2
);
    // Exhaustive testbench limited to small widths; RTL is independently parameterized.
    localparam integer LIMIT = 1 << WIDTH;
    reg [WIDTH-1:0] a, b;
    reg [2:0] op;
    wire [WIDTH-1:0] result;
    wire carry, borrow, zero;
    reg expected_borrow, expected_zero;
    integer ai, bi, oi, expected, tests, errors;
    mini_alu #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .op(op), .result(result),
                  .carry(carry), .borrow(borrow), .zero(zero));

    task check;
        begin
            #1;
            expected_borrow = 1'b0;
            case (oi)
                0: expected = ai + bi;
                1: expected = ai & bi;
                2: expected = ai | bi;
                3: expected = ai ^ bi;
                4: begin
                    // Independent unsigned reference: wrap negative differences.
                    if (ai < bi) begin
                        expected = ai + LIMIT - bi;
                        expected_borrow = 1'b1;
                    end else expected = ai - bi;
                end
                5: expected = LIMIT - 1 - ai; // Bitwise inversion, independent of b.
                6: expected = (ai * 2) % LIMIT; // Left shift with WIDTH-bit wrap.
                7: expected = ai / 2; // Unsigned integer division, independent of b.
                default: expected = 0;
            endcase
            expected_zero = ((expected % LIMIT) == 0);
            tests = tests + 1;
            if ({zero, borrow, carry, result} !==
                {expected_zero, expected_borrow, expected[WIDTH:0]}) begin
                errors = errors + 1;
                $display("FAIL a=%0d b=%0d op=%0d got=%b expected=%b",
                         a, b, op, {zero, borrow, carry, result},
                         {expected_zero, expected_borrow, expected[WIDTH:0]});
            end
        end
    endtask

    initial begin
        if (WIDTH < 1 || WIDTH > 8)
            $fatal(1, "Exhaustive testbench supports WIDTH from 1 through 8");
        // Waveforms are optional to avoid large files for the 8-bit run.
        if ($test$plusargs("dump")) begin
            $dumpfile("mini_alu.vcd");
            $dumpvars(0, tb_mini_alu);
        end
        tests = 0;
        errors = 0;
        // All binary input combinations, traversed in both directions.
        for (ai = 0; ai < LIMIT; ai = ai + 1)
            for (bi = 0; bi < LIMIT; bi = bi + 1)
                for (oi = 0; oi < 8; oi = oi + 1) begin
                    a = ai; b = bi; op = oi;
                    check;
                end
        for (ai = LIMIT - 1; ai >= 0; ai = ai - 1)
            for (bi = LIMIT - 1; bi >= 0; bi = bi - 1)
                for (oi = 7; oi >= 0; oi = oi - 1) begin
                    a = ai; b = bi; op = oi;
                    check;
                end
        if (errors != 0) $fatal(1, "%0d failures", errors);
        if (tests != 16 * LIMIT * LIMIT)
            $fatal(1, "Unexpected number of checks: %0d", tests);
        $display("WIDTH=%0d", WIDTH);
        $display("PASS: %0d checks", tests);
        $finish;
    end
endmodule
