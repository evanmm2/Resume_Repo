module cacheline_adaptor
(
    input clk,
    input rst,

    // Port to LLC (Lowest Level Cache)
    input logic [255:0] line_i,
    output logic [255:0] line_o,
    input logic [31:0] address_i,
    input read_i,
    input write_i,
    output logic resp_o,

    // Port to memory
    input logic [63:0] burst_i,
    output logic [63:0] burst_o,
    output logic [31:0] address_o,
    output logic read_o,
    output logic write_o,
    input resp_i
);

logic [63:0] read_data;
logic [255:0] data;
logic [1:0] select;
always @(posedge clk) begin
	unique case (select)
	2'b00:	data[63:0] <= read_data;
	2'b01:	data[127:64] <= read_data;
	2'b10:	data[191:128] <= read_data;
	2'b11:	data[255:192] <= read_data;
	default: data[64:0] <= read_data;
	endcase
end

enum int unsigned {
	start = 0,
	read_fetch = 1,
	read1 = 2,
	read2 = 3,
	read3 = 4,
	read_done = 5,
	write_fetch = 6,
	write1 = 7,
	write2 = 8,
	write3 = 9,
	write_done = 10
} state, next_state;

always_comb begin
	address_o = address_i;
	resp_o = 1'b0;
	read_o = 1'b0;
	write_o = 1'b0;
	burst_o = 64'h0;
	line_o = 64'h0;
	read_data = 64'h0;
	select = 2'b00;
	unique case (state)
		start: begin
				;
		end
		read_fetch: begin
				read_o = 1'b1;
				read_data = burst_i;
		end
		read1: begin
				read_data = burst_i;
				read_o = 1'b1;
				select = 2'b01;
		end
		read2: begin
				read_data = burst_i;
				read_o = 1'b1;
				select = 2'b10;
		end
		read3: begin
				read_data = burst_i;
				read_o = 1'b1;
				select = 2'b11;
		end
		read_done: begin
				line_o = data;
				resp_o = 1'b1;
		end
		write_fetch: begin
				write_o = 1'b1;
				burst_o = line_i[63:0];
		end
		write1: begin
				burst_o = line_i[127:64];
				write_o = 1'b1;
		end
		write2: begin
				burst_o = line_i[191:128];
				write_o = 1'b1;
		end
		write3: begin
				burst_o = line_i[255:192];
				write_o = 1'b1;
		end
		write_done: begin
				resp_o = 1'b1;
		end
	default: ;
	endcase
end

always_comb begin
	//next state logic
	unique case (state)
			start: begin
					if (read_i == 1'b1)
							next_state = read_fetch;
					else if (write_i == 1'b1)
							next_state = write_fetch;
					else
							next_state = start;
			end
			read_fetch: begin
					if (resp_i == 1'b1)
							next_state = read1;
					else 
							next_state = read_fetch;
			end
			read1: next_state = read2;
			read2: next_state = read3;
			read3: next_state = read_done;
			read_done: next_state = start;
			write_fetch: begin
					if (resp_i == 1'b1)
							next_state = write1;
					else 
							next_state = write_fetch;
			end
			write1: next_state = write2;
			write2: next_state = write3;
			write3: next_state = write_done;
			write_done: next_state = start;
	default: next_state = start;
	endcase
end

always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		state <= start;
	end else begin
		state <= next_state;
	end
end

endmodule : cacheline_adaptor

