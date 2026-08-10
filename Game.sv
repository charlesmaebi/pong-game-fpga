module Game(
	// user controls
	input logic p1_up,
	input logic p1_down,
	input logic reset,
	
	input logic clock50,
	output logic hsync,
	output logic vsync,

	
	output logic [3:0] red_display, // 0000 off 1111 on
	output logic [3:0] blue_display, // 0000 off 1111 on
	output logic [3:0] green_display // 0000 off 1111 on

	
);

wire [9:0] ball_upper, ball_lower, ball_left, ball_right;
wire [9:0] paddle1_upper, paddle1_lower, paddle1_left, paddle1_right;
wire clock25;

ClockDivider clock_divider(
	.clock50(clock50),
	.reset(reset),
	.clock25(clock25)
);

logic vsync_prev;
logic frame_tick;

always_ff @(posedge clock25) begin
    vsync_prev <= vsync;
end

assign frame_tick = vsync & ~vsync_prev;

Ball ball(
	.reset(reset),
	.enable(frame_tick),
	.clock25(clock25),
	.p1_upper(paddle1_upper),
	.p1_lower(paddle1_lower),
	.p1_up(p1_up),
	.p1_down(p1_down),
	.upper(ball_upper),
	.lower(ball_lower),
	.right(ball_right),
	.left(ball_left)
);

Paddle paddle1(
	.dir_up(p1_up),
	.dir_down(p1_down),
	.enable(frame_tick),
	.player(0),
	.reset(reset),
	.clock25(clock25),
	.paddle_upper(paddle1_upper),
	.paddle_lower(paddle1_lower),
	.paddle_right(paddle1_right),
	.paddle_left(paddle1_left)
);

GraphicsDriver driver(
	.clock25(clock25),
	.reset(reset),
	.hsync(hsync),
	.vsync(vsync),
	.red_display(red_display),
	.blue_display(blue_display),
	.green_display(green_display),
	.ball_upper(ball_upper),
	.ball_lower(ball_lower),
	.ball_right(ball_right),
	.ball_left(ball_left),
	.paddle1_upper(paddle1_upper),
	.paddle1_lower(paddle1_lower),
	.paddle1_right(paddle1_right),
	.paddle1_left(paddle1_left)
);

endmodule

