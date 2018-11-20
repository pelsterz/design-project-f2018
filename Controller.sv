module Controller(
	input logic clk,
	output logic _latch,
	output logic _clock,
	output logic [7:0] data
);

	logic [2:0] count = 0;
	
	always_ff @(posedge clk)
		begin
			count <= count + 1;
			
			_latch <= 0;
			
			if (count == 7)
				begin
					count <= 0;
					_latch <= 1;
					_clock <= 0;
				end
				
			else 
				_clock <= 1;
			
		end
	
endmodule

	