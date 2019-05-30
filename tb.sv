`include "timescale.v"
module tb ();
localparam ADC_BITS = 8;
localparam ADC_VPP  = 1; // ADC Vpk-pk
localparam ADC_PIPE = 5; // Pipeline delay

logic clk = 1;
always #500 clk <= ~clk; // 100 MHz (1ps time step)

real u;
real u_r; // resistor voltage
real u_c; // capacitor voltage
real u_l; // inductance voltage
real i;   // current
real u_err;

logic adc_ovfl_pos;
logic adc_ovfl_neg;

logic [ADC_BITS-1:0] adc_code;

// series RLC circuit
rlc_sim #(
	.dt (0.000000000001), // 1ps
	.L  (0.0000001),
	.C  (0.00000001),
	.R  (1)
) rlc_sim_inst (
    .u    (u),

    .u_r  (u_r), 
    .u_c  (u_c), 
    .u_l  (u_l), 

    .i    (i),
	.u_err (u_err)
);

assign adc_clk = clk;
adc_sim #(
	.BITS (ADC_BITS),
	.VPP  (ADC_VPP),
	.PIPE (ADC_PIPE),
	.TYPE ("unsigned")
)
adc_sim_inst (
	.clk  (adc_clk),
	.in   (i),
	.code (adc_code),
	
	.ovfl_pos (adc_ovfl_pos),
	.ovfl_neg (adc_ovfl_neg)
);

// Stiumuls (input voltage)
initial begin
	#100000  u = 8;
	#1000000 u = 0;
end

endmodule

