module DrawBall(
	input logic [9:0] h_counter,
	input logic [9:0] v_counter,
	input logic reset,
	input logic [9:0] ball_upper,
	input logic [9:0] ball_lower,
	input logic [9:0] ball_left,
	input logic [9:0] ball_right,
	input logic  [9:0] paddle_upper,
	input logic [9:0] paddle_lower,
	input logic [9:0] paddle_left,
	input logic [9:0] paddle_right,
	output logic [3:0] color
);

always_comb begin 
	if (reset) begin 
		color = 4'b0000;
	end
	else if (((h_counter >= ball_left && h_counter <= ball_right) && (v_counter >= ball_upper && v_counter <= ball_lower)) ||
	((h_counter >= paddle_left && h_counter <= paddle_right) && (v_counter >= paddle_upper && v_counter <= paddle_lower))) begin 
		color = 4'b1111;
	end 
	else begin 
		color = 4'b0000;
	end
end

endmodule