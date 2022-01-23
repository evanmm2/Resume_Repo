module alu
(
    input logic [2:0] aluop,
    input logic [31:0] a, b,
    output logic [31:0] f
);

always_comb
begin
     case (aluop)
		  //add
        3'b000:  f = a + b;
		  //sll
        3'b001:  f = a << b[4:0];
		  //sra
        3'b010:  f = $signed(a) >>> b[4:0];
		  //sub
        3'b011:  f = a - b;
		  //xor
        3'b100:  f = a ^ b;
		  //srl
        3'b101:  f = a >> b[4:0];
		  //or
        3'b110:   f = a | b;
		  //and
        3'b111:  f = a & b;
		  default: f = a + b;
    endcase
end

endmodule : alu
