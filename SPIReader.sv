module SPIReader(
	input logic _c,
	input logic _l,
	input logic [7:0] d,
	output logic [3:0] move
);

	logic [2:0] counter = 0;
	
	always_ff@(posedge _c)
		begin
			
		end
		
	always_ff@(posedge _l)
		begin
			
		end
		
endmodule
