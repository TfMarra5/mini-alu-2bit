`timescale 1ns/1ps
module tb_mini_alu;
    reg [1:0] a, b;
    reg [2:0] op;
    wire [1:0] result;
    wire carry;
    integer ai, bi, oi, expected, tests, errors;
    mini_alu dut (.a(a), .b(b), .op(op), .result(result), .carry(carry));

    task check;
        begin
            #1;
            case (oi)
                0: expected = ai + bi;
                1: expected = ai & bi;
                2: expected = ai | bi;
                3: expected = ai ^ bi;
                default: expected = 0;
            endcase
            tests = tests + 1;
            if ({carry, result} !== expected[2:0]) begin
                errors = errors + 1;
                $display("FAIL a=%0d b=%0d op=%0d got=%b expected=%b",
                         a, b, op, {carry, result}, expected[2:0]);
            end
        end
    endtask

    initial begin
        $dumpfile("mini_alu.vcd");
        $dumpvars(0, tb_mini_alu);
        tests = 0;
        errors = 0;
        // All 128 combinations, plus reverse traversal to check transitions.
        for (ai = 0; ai < 4; ai = ai + 1)
            for (bi = 0; bi < 4; bi = bi + 1)
                for (oi = 0; oi < 8; oi = oi + 1) begin
                    a = ai; b = bi; op = oi;
                    check;
                end
        for (ai = 3; ai >= 0; ai = ai - 1)
            for (bi = 3; bi >= 0; bi = bi - 1)
                for (oi = 7; oi >= 0; oi = oi - 1) begin
                    a = ai; b = bi; op = oi;
                    check;
                end
        if (errors != 0) $fatal(1, "%0d failures", errors);
        $display("PASS: %0d checks", tests);
        $finish;
    end
endmodule
