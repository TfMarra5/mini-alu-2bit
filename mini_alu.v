// Configurable unsigned ALU (WIDTH >= 1; default 2).
// 000 ADD, 001 AND, 010 OR, 011 XOR, 100 SUB, 101 NOT A.
// 110 SHL A, 111 SHR A, both by one bit. Unary operations ignore b.
module mini_alu #(
    parameter integer WIDTH = 2
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire [2:0] op,
    output reg  [WIDTH-1:0] result,
    output reg        carry,
    output reg        borrow,
    output wire       zero
);
    // Zero describes result only, independently of carry and borrow.
    assign zero = (result == {WIDTH{1'b0}});
    always @(*) begin
        result = {WIDTH{1'b0}};
        carry = 1'b0;
        borrow = 1'b0;
        case (op)
            3'b000: {carry, result} = {1'b0, a} + {1'b0, b};
            3'b001: result = a & b;
            3'b010: result = a | b;
            3'b011: result = a ^ b;
            3'b100: begin
                result = a - b; // Low WIDTH bits: subtraction modulo 2**WIDTH.
                borrow = (a < b);
            end
            3'b101: result = ~a;
            3'b110: result = a << 1; // Discard top bit; flags stay zero.
            3'b111: result = a >> 1; // Unsigned logical shift; flags stay zero.
            default: begin
                result = {WIDTH{1'b0}};
                carry = 1'b0;
            end
        endcase
    end
endmodule
