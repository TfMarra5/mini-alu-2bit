// 2-bit ALU: 000 ADD, 001 AND, 010 OR, 011 XOR; 100-111 reserved.
module mini_alu (
    input  wire [1:0] a,
    input  wire [1:0] b,
    input  wire [2:0] op,
    output reg  [1:0] result,
    output reg        carry
);
    always @(*) begin
        result = 2'b00;
        carry = 1'b0;
        case (op)
            3'b000: {carry, result} = {1'b0, a} + {1'b0, b};
            3'b001: result = a & b;
            3'b010: result = a | b;
            3'b011: result = a ^ b;
            default: begin
                result = 2'b00;
                carry = 1'b0;
            end
        endcase
    end
endmodule
