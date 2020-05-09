function [sfr] = get_sfr(q)
global mass_each_link;
global G_link; 
G_link = mass_each_link*9.8;
global m;
global n;

m = 25;   % forward rate
n = 360;  % number of directions

F_des1 = F_des(n);

global B; 
B = F_des1;

X_reality = F_real(q);

delt_x = squeeze(X_reality(1,m,:));
delt_y = squeeze(X_reality(2,m,:));
sfr =[delt_x  delt_y];
% 
% disp(size(delt_x))
% disp(size(delt_y))
end

