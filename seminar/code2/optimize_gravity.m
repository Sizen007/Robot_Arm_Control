function [q_res, sigma_revs] = optimize_gravity(~)
global kc;
global q_initial;


cost_func =@(q)  ((kc\Gq(q))' * (kc\Gq(q)));
A=[];
b=[];
Aeq=[];
Beq=[];
lb= [ -pi+pi/60, -pi+pi/30, -pi+pi/30, -pi+pi/30];
ub=[   pi-pi/60,    pi-pi/30,    pi-pi/30,   pi-pi/30];
options = optimoptions('fmincon',  'Algorithm', 'sqp', 'OutputFcn',@outfunc);
[q_res, sigma_revs] = fmincon(cost_func, q_initial, A, b, Aeq, Beq, lb, ub, @nonlinear_constr,options);
%Gq_out = Gq(q_res);
end

function [res, tau_g] = Gq(q)
global mass_each_link;
global l1;
global l2;
global l3;
global l4;
G_link = mass_each_link*9.8;

tau_g = [G_link*l1/2*cos(q(1)) + G_link*[l1*cos(q(1)) + l2/2*cos(sum(q([1:2])))] + G_link*[l1*cos(q(1)) + l2*cos(sum(q([1:2]))) + l3/2*cos(sum(q([1:3])))]  + G_link*[l1*cos(q(1)) + l2*cos(sum(q([1:2]))) + l3*cos(sum(q([1:3]))) + l4/2 *cos(sum(q))];
                                         G_link*l2/2*cos(sum(q(1:2))) + G_link*(l3/2*cos(sum(q(1:3))) +l2*cos(sum(q(1:2)))) +  G_link*(l4/2 *cos(sum(q))+l3*cos(sum(q(1:3))) +l2*cos(sum(q(1:2))))   ;                                                                                                                                                   ;  
                                         G_link*l3/2*cos(sum(q([1:3]))) + G_link*[l3*cos(sum(q([1:3]))) + l4/2*cos(sum(q))] ;                                                                                                                         
                                         G_link*l4/2 *cos(sum(q)) ];
                                     
res = get_jacob(q)' \ tau_g;
end

function stop = outfunc(x,optimValues,state)

[~, tau_g] = Gq(x);
global norm_list;
norm_list = [norm_list, norm(tau_g)];

stop= 0;
end



