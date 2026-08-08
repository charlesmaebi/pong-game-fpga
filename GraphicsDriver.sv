module GraphicsDriver(
	input logic clock50,
	input logic reset,
	output logic hsync,
	output logic vsync,

	
	output logic [3:0] red_display, // 0000 off 1111 on
	output logic [3:0] blue_display, // 0000 off 1111 on
	output logic [3:0] green_display // 0000 off 1111 on
);

wire clock25;
wire [3:0] red_decoded, green_decoded, blue_decoded;
wire [9:0] h_counter, v_counter;
wire [3:0] color;
wire [9:0] upper, lower, left, right;

ClockDivider clock_divider(
	.clock50(clock50),
	.reset(reset),
	.clock25(clock25)
);

SyncCount sync_count(
	.enable(clock25),
	.reset(reset),
	.hsync(hsync),
	.vsync(vsync),
	.h_counter(h_counter),
	.v_counter(v_counter)
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
	.upper(upper),
	.lower(lower),
	.right(right),
	.left(left)
);

DrawBall draw_ball(
	.reset(reset),
	.h_counter(h_counter),
	.v_counter(v_counter),
	.upper(upper),
	.lower(lower),
	.right(right),
	.left(left),
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
