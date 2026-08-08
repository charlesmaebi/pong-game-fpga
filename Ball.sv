module Ball(
	input logic reset,
	input logic enable, // enables based on vsync high/low
	input logic clock25,
	input logic p1_upper,
	input logic p1_lower,
	
	
	
	output logic [9:0] upper, 
	output logic [9:0] lower,
	output logic [9:0] left,
	output logic [9:0] right
);

typedef enum logic [1:0] {
    UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT
} direction_t;

direction_t direction;

localparam [9:0] SPEED = 10'd1;

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