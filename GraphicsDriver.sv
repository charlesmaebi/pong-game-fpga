module GraphicsDriver(
	input logic clock25,
	input logic reset,
	output logic hsync,
	output logic vsync,
	
	input logic [9:0] ball_upper,
	input logic [9:0] ball_lower,
	input logic [9:0] ball_right,
	input logic [9:0] ball_left,
	
	input logic [9:0] paddle1_upper,
	input logic [9:0] paddle1_lower,
	input logic [9:0] paddle1_right,
	input logic [9:0] paddle1_left,

	
	output logic [3:0] red_display, // 0000 off 1111 on
	output logic [3:0] blue_display, // 0000 off 1111 on
	output logic [3:0] green_display // 0000 off 1111 on
);

wire [3:0] red_decoded, green_decoded, blue_decoded;
wire [9:0] h_counter, v_counter;
wire [3:0] color;

SyncCount sync_count(
	.enable(clock25),
	.reset(reset),
	.hsync(hsync),
	.vsync(vsync),
	.h_counter(h_counter),
	.v_counter(v_counter)
);

DrawBall draw_ball(
	.reset(reset),
	.h_counter(h_counter),
	.v_counter(v_counter),
	.ball_upper(ball_upper),
	.ball_lower(ball_lower),
	.ball_right(ball_right),
	.ball_left(ball_left),
	.paddle_right(paddle1_right),
	.paddle_left(paddle1_left),
	.paddle_upper(paddle1_upper),
	.paddle_lower(paddle1_lower),
	.color(color)
);

Mux red_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(color),
	.display(red_display)
);

Mux green_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(color),
	.display(green_display)
);


Mux blue_mux(
	.hsync(hsync),
	.vsync(vsync),
	.color(color),
	.display(blue_display)
);


endmodule
