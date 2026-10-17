// 2-bit ALU: 000 ADD, 001 AND, 010 OR, 011 XOR, 100 SUB, 101 NOT A.
// 110 SHL A by one bit; 111 reserved. Unary operations ignore b.
module mini_alu (
    input  wire [1:0] a,
    input  wire [1:0] b,
    input  wire [2:0] op,
    output reg  [1:0] result,
    output reg        carry,
    output reg        borrow
);
    always @(*) begin
        result = 2'b00;
        carry = 1'b0;
        borrow = 1'b0;
        case (op)
            3'b000: {carry, result} = {1'b0, a} + {1'b0, b};
            3'b001: result = a & b;
            3'b010: result = a | b;
            3'b011: result = a ^ b;
            3'b100: begin
                result = a - b; // Low two bits: subtraction modulo 4.
                borrow = (a < b);
            end
            3'b101: result = ~a;
            3'b110: result = {a[0], 1'b0}; // Discard a[1]; flags stay zero.
            default: begin
                result = 2'b00;
                carry = 1'b0;
            end
        endcase
    end
endmodule
