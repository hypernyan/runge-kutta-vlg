`include "timescale.v"
module rlc_sim #(
    parameter dt = 0.000000001, // 1ns
    parameter L = 0.0001,
    parameter C = 0.0001,
    parameter R = 0.01
)
(
    input  real u,

    output real u_r, 
    output real u_c, 
    output real u_l, 

    output real i,
    output real u_err
);

real  k1;
real  k2;
real  k3;
real  k4;

real  l1;
real  l2;
real  l3;
real  l4;

real z_prev;
real q_prev;
real u_prev;

real q; // charge 
real z; // first direvative from charge (create two 1st order equatuions for one 2nd order)

real q_cur; 
real z_cur;

assign i = z;

always #1 begin
	u_prev <= u;
	z_prev <= z;
	q_prev <= q;
end

always @* begin
	k1 = z_prev;
	l1 = (u_prev - R*z_prev - (1/C)*q_prev)/L;
	k2 = z_prev + dt*l1/2;
	l2 = ((u + u_prev)/2 - R*(z_prev + dt*l1/2) - (1/C)*(q_prev + dt*k1/2))/L;
	k3 = z_prev + dt*l2/2;
	l3 = ((u + u_prev)/2 - R*(z_prev + dt*l2/2) - (1/C)*(q_prev + dt*k2/2))/L;
	k4 = z_prev + dt*l3;
	l4 = (u   - R*(z_prev + dt*l3)   - (1/C)*(q_prev + dt*k3)  )/L;
	q  = q_prev + (dt/6)*(k1+2*k2+2*k3+k4); 
	z  = z_prev + (dt/6)*(l1+2*l2+2*l3+l4); 
end

assign u_r   = z*R;
assign u_c   = q/C;
assign u_l   = L*(z-z_prev)/dt;
assign u_err = u - (u_r + u_c + u_l);

endmodule