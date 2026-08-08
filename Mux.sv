module Mux(
	input logic vsync,
	input logic hsync,
	input logic [3:0] color,
	output logic [3:0] display
);

always_comb begin 
	if (vsync && hsync) begin 
		display = color;
	end
	else begin 
		display = 4'b0000;
	end
end

endmodule