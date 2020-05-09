function [c,ceq] = nonlinear_constr(q)
global ee_initial_position;
% ceq = forward_kine(q) - ee_initial_position;

ee_res = forward_kine(q);
ceq = ee_res([1,2],4) - ee_initial_position([1,2],4);

c = [];
end