module SyncCount(
	input logic enable,
	input logic reset,
	input logic color,
	output logic hsync,
	output logic vsync, 
	output logic [9:0] h_counter,
	output logic [9:0] v_counter
);

always_ff @(posedge enable or posedge reset) begin
	if (reset) begin 
		h_counter <= 0;
		v_counter <= 0;
		hsync <= 0; 
		vsync <= 0; 
	end
	else begin 

		if (h_counter == 800) begin 
			h_counter <= 10'd0;  

			if (v_counter == 524)  
				v_counter <= 10'd0;  
			else
				v_counter <= v_counter + 1;
		end
		else begin 
			h_counter <= h_counter + 1;
		end
		
		if (h_counter < 96)  
			hsync <= 0;
		else
			hsync <= 1;
		
		if (v_counter < 2) 
			vsync <= 0;
		else
			vsync <= 1;
	end
end
endmodule
	