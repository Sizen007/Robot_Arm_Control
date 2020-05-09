function [q_res, sigma_revs] = optimize_sfe(unit_direction)
global kc;
global w_tau;
global q_initial;

A=[];
b=[];
Aeq=[];
Beq=[];
lb= [ -pi+pi/60, -pi+pi/30, -pi+pi/30, -pi+pi/30];
ub=[   pi-pi/60,    pi-pi/30,    pi-pi/30,   pi-pi/30];

cost_func =@(q)  (unit_direction' * kc * get_jacob(q)* w_tau^2 *  get_jacob(q)' * kc * unit_direction)^0.5;
options = optimoptions('fmincon',  'Algorithm', 'sqp', 'OutputFcn',@outfunc);
[q_res, sigma_revs] = fmincon(cost_func, q_initial, A, b, Aeq, Beq, lb, ub, @nonlinear_constr, options);
end


function stop = outfunc(x,optimValues,state)
stop=0;
%disp(x);
end