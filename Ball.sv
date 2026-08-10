module Ball(
	input logic reset,
	input logic enable, // enables based on vsync high/low
	input logic clock25,
	input logic [9:0] p1_upper,
	input logic [9:0] p1_lower,
	input logic p1_up,
	input logic p1_down,
	
	
	output logic [9:0] upper, 
	output logic [9:0] lower,
	output logic [9:0] left,
	output logic [9:0] right

);

typedef enum logic [2:0] {
    UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT, STRAIGHT_RIGHT, STRAIGHT_LEFT
} direction_t;

direction_t direction;

localparam [9:0] SPEED = 10'd3;

localparam [5:0] BALL_HEIGHT = 6'd10;
localparam [5:0] BALL_WIDTH = 6'd8;

localparam [9:0] TOP_SCREEN = 10'd34;
localparam [9:0] BOTTOM_SCREEN = 10'd514;
localparam [9:0] LEFT_SCREEN = 10'd143;
localparam [9:0] SCREEN_RIGHT = 10'd783;

always_ff @(posedge clock25 or posedge reset) begin 
	// center screen
	if (reset) begin
		upper <= 10'd240 - BALL_HEIGHT;
		lower <= 10'd240 + BALL_HEIGHT;
		left <= 10'd320 - BALL_WIDTH;
		right <= 10'd320 + BALL_WIDTH;
		direction <= DOWN_LEFT;
	end
	else if (enable) begin 
	
		if (upper <= TOP_SCREEN) begin 
			case (direction)
				UP_LEFT: begin
					direction <= DOWN_LEFT;
				end
				UP_RIGHT: begin
					direction <= DOWN_RIGHT;
				end
			endcase
		end
		
		if (lower >= BOTTOM_SCREEN) begin 
			case (direction)
				DOWN_LEFT: begin
					direction <= UP_LEFT;
				end
				DOWN_RIGHT: begin 
					direction <= UP_RIGHT;
				end
			endcase
		end
		
		if (left <= LEFT_SCREEN) begin 
			case (direction)
				UP_LEFT: begin
					direction <= UP_RIGHT;
				end
				DOWN_LEFT: begin
					direction <= DOWN_RIGHT;
				end
			endcase
			
		end
		
		if (right >= SCREEN_RIGHT) begin 
			case (direction)
				UP_RIGHT: begin
					direction <= UP_LEFT;
				end
				DOWN_RIGHT: begin
					direction <= DOWN_LEFT;
				end
			endcase
		end
		
		// Check collision with paddle one
		/* Behavior:
			If the ball is going up left, and the paddle is going up, go up right
			If the ball is going up left, but the paddle is not moving, go straight,
			If a paddle and ball collide in opposite directions, go straight
			and vise versa 
		*/
		if ((left <= LEFT_SCREEN + 11) && (upper < p1_lower) && (lower > p1_upper)) begin
			if (lower < ((p1_lower + p1_upper) / 2)) 
				direction <= UP_RIGHT;
			else
				direction <= DOWN_RIGHT;
		end
		
		case (direction)
			UP_LEFT: begin 
				upper <= upper - SPEED;
            lower <= lower - SPEED;
            left  <= left  - SPEED;
            right <= right - SPEED;
			end
			UP_RIGHT: begin
				upper <= upper - SPEED;
            lower <= lower - SPEED;
            left  <= left + SPEED;
            right <= right + SPEED;
			end
			DOWN_LEFT: begin 
				upper <= upper + SPEED;
            lower <= lower + SPEED;
            left  <= left  - SPEED;
            right <= right - SPEED;
			end
			DOWN_RIGHT: begin 
				upper <= upper + SPEED;
            lower <= lower + SPEED;
            left  <= left  + SPEED;
            right <= right + SPEED;
			end
		endcase
	end
end

endmodule