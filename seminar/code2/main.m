clc
clear all
close all

%% four links robot arm parameters
    global l1;
    global l2;
    global l3;
    global l4;
%     l1 = 0.14; 
%     l2 = 0.12;
%     l3 = 0.12;
%     l4 = 0.14;
    l1 = 0.2; 
    l2 = 0.2;
    l3 = 0.2;
    l4 = 0.2;

    global kc;
    global w_tau;
%     kc = [1000,200;
%              200,1000];
        kc = [100,20;
                20,100];
    w_tau =    [1/5, 0,    0,   0;
                       0,    1/4, 0,   0;
                       0,    0,    1/3,0;
                       0,    0,    0,   1/2];
    global mass_each_link;
    global q_initial;
    global G_link ; 
    global m;
    global n;
    mass_each_link = 0.025;
    q_initial = [30, 30, -70, 45]/180*pi; 
    G_link = mass_each_link*9.8;
    m = 25;   % forward rate
    n = 360;  % number of directions
%% initial position and jacobian
%initial_jacobian_q = get_jacob(q_initial)
global ee_initial_position;
global points_initial;
[ee_initial_position, points_initial] = forward_kine(q_initial);

%%  sfe optimize
% unit_direction = [-1/sqrt(2); 1/sqrt(2)];
unit_direction = [-1; 0];
[q_res_sfe, sigma_revs] = optimize_sfe(unit_direction);
optimized_sigma_SFE = 1 / sigma_revs;
[Hend, points_res_SFE] = forward_kine(q_res_sfe);

%% gravity optimize
global norm_list;
norm_list = [];

[q_res_gravity, sigma_revs] = optimize_gravity();
sigma = 1 / sigma_revs;
[Hend, points_res_gravity] = forward_kine(q_res_gravity);

%% combined optimize
% unit_direction = [-1; 0];
% [q_res_combined, sigma_revs] = optimize_combined(unit_direction);
% optimized_sigma_combined = 1 / sigma_revs;
% [Hend, points_res_combined] = forward_kine(q_res_combined);
%% visualization sfe
f1 = figure;
plot_data(f1, 'optimized SFE', q_res_sfe, points_res_SFE)

%% visualization gravity
f2 = figure;
plot_data(f2, 'optimized gravity', q_res_gravity, points_res_gravity)
f3 = figure;
figure(f3);
plot(norm_list);

%% print
 sprintf('sigma  = %d ',sigma)



