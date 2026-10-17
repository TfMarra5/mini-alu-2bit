// 2-bit combinational ALU: 00 ADD, 01 AND, 10 OR, 11 XOR.
module mini_alu (
    input  wire [1:0] a,
    input  wire [1:0] b,
    input  wire [1:0] op,
    output reg  [1:0] result,
    output reg        carry
);
    always @(*) begin
        result = 2'b00;
        carry = 1'b0;
        case (op)
            2'b00: {carry, result} = {1'b0, a} + {1'b0, b};
            2'b01: result = a & b;
            2'b10: result = a | b;
            2'b11: result = a ^ b;
            default: begin
                result = 2'b00;
                carry = 1'b0;
            end
        endcase
    end
endmodule
