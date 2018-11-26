module ps2_keyboard(
	input logic clock, //Clock pin for keyboard
	input logic data, //Data pin for keyboard
	output logic [7:0] data_out
);

	logic [7:0] current_data;
	logic [7:0] previous_data;
	logic [3:0] b;
	logic flag;
	
	initial
	begin
		b <= 4'h1;
		flag <= 1'b0;
		current_data <= 8'h0;
		previous_data <= 8'h0;
		data_out <= 8'h0;
	end
	
	always_ff @(negedge clock)
		begin
			case(b)
				1:; //First bit
				2: current_data[0] <= data;
				3: current_data[1] <= data;
				4: current_data[2] <= data;
				5: current_data[3] <= data;
				6: current_data[4] <= data;
				7: current_data[5] <= data;
				8: current_data[6] <= data;
				9: current_data[7] <= data;
				10: flag <= 1'b1; //Parity bit
				11: flag <= 1'b0; //Ending bit
			
			endcase
			
			if(b <= 10) //Check to see if b needs to be reset
				b <= b+1; //Increment b
				
			else if(b == 11) //Check to see if b needs to be reset
				b <= 1; //Reset b
				
			end
			
		always_ff @(posedge flag) //Printing data sent to the led
			begin
				if(current_data == 8'h0)
					data_out <= previous_data;
				
				else
					previous_data <= current_data;
					
			end
			
endmodule
			
			