module cmp
(
	input logic [31:0] cmp1,
	input logic [31:0] cmp2,
	input logic [2:0] cmpop,
	output logic br_en
);

always_comb begin
		unique case (cmpop)
				//BEQ
				3'b000: br_en = (cmp1 == cmp2);
				//BNE
				3'b001: br_en = (cmp1 != cmp2);
				//BLT
				3'b100: begin
					if (cmp1[31] == 1'b1 && cmp2[31] == 1'b0) begin
							br_en = 1'b1;
					end else if (cmp1[31] == 1'b0 && cmp2[31] == 1'b1)begin
							br_en = 1'b0;
					end else begin
							br_en = cmp1 < cmp2;
					end
				end
				//BGE
				3'b101: begin
						if (cmp1[31] == 1'b1 && cmp2[31] == 1'b0) begin
							br_en = 1'b0;
					end else if (cmp1[31] == 1'b0 && cmp2[31] == 1'b1)begin
							br_en = 1'b1;
					end else begin
							br_en = cmp1 >= cmp2;
					end
				end
				//BLTU
				3'b110: br_en = (cmp1 < cmp2);
				//BGEU
				3'b111: br_en = (cmp1 >= cmp2);
				default: br_en = 1'b0;
		endcase
end

endmodule : cmp