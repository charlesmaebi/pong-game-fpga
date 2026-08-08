module ClockDivider(
	input logic clock50,
	input logic reset,
	output logic clock25
);
	logic toggle;
    
always_ff @(posedge clock50 or posedge reset) begin
	if (reset)
		toggle <= 1'b0;
	else
		toggle <= !toggle;
end
    
assign clock25 = toggle; // enable_n should toggle at 25 MHz
endmodule