module ps2_keyboard(
	input logic clock, //Clock pin for keyboard
	input logic data, //Data pin for keyboard
	output logic [7:0] data_out
);

	logic [3:0] count = 4'b0000; //Counts number of clock cycles
	logic parityCheck; 
	logic [10:0] temp_data = 11'b00000000000; //Holds data

		always_ff @(negedge clock)
			begin
				
				//Shift data value into the temp register
				if(clock)
					begin
						count <= 0;
					end
				
				//Case statement that loads output and increments counter
				else
				
					begin
						case(count)
							11: 
								
								begin
									temp_data <= {temp_data[9:0], data};
									count <= 1;
								end
							
							default:
						
								begin
									count <= count + 1;
									temp_data <= {temp_data[9:0], data};
								end
				
						endcase
					
					end
				
			end
		
			//Set output after counter is complete and data is valid
			always_comb 
				
				begin
					//Set parity check
					parityCheck = ^temp_data[9:1];
					
					if(temp_data[0] && ~temp_data[10] && parityCheck && count >= 10)
					
						begin
							data_out[0] = temp_data[9];
							data_out[1] = temp_data[8];
							data_out[2] = temp_data[7];
							data_out[3] = temp_data[6];
							data_out[4] = temp_data[5];
							data_out[5] = temp_data[4];
							data_out[6] = temp_data[3];
							data_out[7] = temp_data[2];
						end
						
					else
						
						begin
							data_out = 8'b00000000;
						end
				
				end
				
endmodule
			
			