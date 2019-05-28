module rlc_sim ();

parameter dt = 0.000000001; // 1ns
parameter L = 0.0001;
parameter C = 0.0001;
parameter R = 0.01;

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
real q;
real z;
real u;

assign k1 = z;
assign k2 = z + dt*l1/2;
assign k3 = z + dt*l2/2;
assign k4 = z + dt*l3/2;

assign l1 = (      u        - R*z_prev             - (1/C)* q_prev           )/L;
assign l2 = ((u_prev - u)/2 - R*(z_prev + dt*l1/2) - (1/C)*(q_prev + dt*k1/2))/L;
assign l3 = ((u_prev - u)/2 - R*(z_prev + dt*l2/2) - (1/C)*(q_prev + dt*k2/2))/L;
assign l4 = ((u_prev - u)   - R*(z_prev + dt*l3)   - (1/C)*(q_prev + dt*k3)  )/L;

always #1 begin
	q = q_prev + (dt/6)*(k1+2*k2+2*k3+k4); 
	z = z_prev + (dt/6)*(l1+2*l2+2*l3+l4); 
	u_prev = u;
	z_prev = z;
	q_prev = q;
end

initial begin
	u <= 0;
	#1000
	u <= 1;
	#20000
	u <= 0;
	#10000
	u <= 1;
	#30000
	u <= 0;
	#10000
	u <= 1;
	#30000
	u <= 0;
end

endmodule
