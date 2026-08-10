module Paddle(
	input logic dir_up,
	input logic dir_down,
	input logic enable,
	input logic player,
	input logic reset,
	input logic clock25,
	
	output logic  [9:0] paddle_upper,
	output logic [9:0] paddle_lower,
	output logic [9:0] paddle_left,
	output logic [9:0] paddle_right
	
	

);

localparam [9:0] SPEED = 10'd7;

localparam [9:0] TOP_SCREEN = 10'd34;
localparam [9:0] BOTTOM_SCREEN = 10'd514;
localparam [9:0] LEFT_SCREEN = 10'd143;
localparam [9:0] RIGHT_SCREEN = 10'd783;

localparam [9:0] PADDLE_WIDTH = 4;
localparam [9:0] PADDLE_HEIGHT = 40;

localparam [9:0] SCREEN_V_CENTER = (BOTTOM_SCREEN + TOP_SCREEN) / 2;

always_ff @(posedge clock25 or posedge reset) begin
	if (reset) begin 
		paddle_upper <= SCREEN_V_CENTER - PADDLE_HEIGHT;
		paddle_lower <= SCREEN_V_CENTER + PADDLE_HEIGHT;
		if (player) begin
			paddle_right <= RIGHT_SCREEN - PADDLE_WIDTH;
			paddle_left <= RIGHT_SCREEN - (2 * PADDLE_WIDTH);
		end
		else begin 
			paddle_right <= LEFT_SCREEN + (2 * PADDLE_WIDTH);
			paddle_left <= LEFT_SCREEN + PADDLE_WIDTH;
		end	
	end
	else if (enable) begin
		if (dir_up && dir_down) begin 
			paddle_upper <= paddle_upper;
			paddle_lower <= paddle_lower;
		end
		else if (dir_up) begin
			if (paddle_upper <= TOP_SCREEN) begin 
				paddle_upper <= paddle_upper;
				paddle_lower <= paddle_lower;
			end
			else begin
				paddle_upper <= paddle_upper - SPEED;
				paddle_lower <= paddle_lower - SPEED;
			end
		end
		else if (dir_down) begin
			if (paddle_lower >= BOTTOM_SCREEN) begin 
				paddle_upper <= paddle_upper;
				paddle_lower <= paddle_lower;
			end
			else begin
				paddle_upper <= paddle_upper + SPEED;
				paddle_lower <= paddle_lower + SPEED;
			end
			
		end
	end
end

endmodule