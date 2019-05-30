`include "timescale.v"
module adc_sim #(
	parameter      BITS = 8,
	parameter real VPP  = 1.0,
	parameter      PIPE = 5,
	parameter      TYPE = "unsigned"
)
(
	input  logic clk,
	input  real  in,
	output logic [BITS-1:0] code,
	output logic ovfl_pos,
	output logic ovfl_neg
);

logic [PIPE-1:0][BITS-1:0] pipe;
assign code = pipe[PIPE-1];

assign ovfl_pos = in >= (VPP/2);
assign ovfl_neg = in <= (-VPP/2);

always @ (posedge clk) begin
	pipe[0] <= (ovfl_pos || ovfl_neg) ? ({~ovfl_pos, {(BITS-1){ovfl_pos}}}) : $floor((in/VPP)*(2**BITS));
	pipe[PIPE-1:1] <= pipe[PIPE-2:0];
end

endmodule

