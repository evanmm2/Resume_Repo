module randomizer ( //Based off of simplefpga's LFSR
input Clk, Reset,
output [3:0] Next_Shape

);

logic [3:0] count, count_in;
logic feedback;

logic [13:0] random, random_in, random_done, random_done_in;
always_ff @(posedge Clk)
begin
    if (Reset) begin
        random <= 14'hF;
        count  <= 4'd0;
    end
    else begin
        random <= random_in;
        count <= count_in;
        random_done <= random_done_in;
    end
end

always_comb
begin
feedback = random [13] ^ random[4] ^ random[3] ^ random[1];
    random_done_in = random_done;
    
    random_in = {random[12:0], feedback};
    count_in = count + 1;

    if (count == 4'd14)
    begin
        count_in = 4'd0;
        random_done_in = random;
    end
end
assign Next_Shape = random_done[3:0] % 8;

endmodule


