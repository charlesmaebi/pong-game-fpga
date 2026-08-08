module BallCollision(
	input logic reset,
	input logic enable, // enables based on vsync high/low
	input logic clock,
	input direction_t direction, // enum
	
	output logic [9:0] upper, 
	output logic [9:0] lower,
	output logic [9:0] left,
	output logic [9:0] right
);