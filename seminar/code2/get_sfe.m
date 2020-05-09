function  [ellpsoid]=  get_sfe(q)
global kc;
global w_tau;

% xres=[];
% yres=[];
%%tau_lim = J' K X
% for x = linspace(-0.06, 0.06, 300)
%     for y = linspace(-0.06,0.06, 300)
%         f = w_tau * get_jacob(q)' * kc * [x;y];
%         ff = f' *f;
%         if ff>0.99 && ff<=1
%             xres = [xres, x];
%             yres = [yres, y];
%         end
%     end
% end
% % scatter(xres, yres, color);
% ellpsoid = [xres;yres];
% 
% e = 0;
% end




[u,s,v] = svd(pinv(w_tau*get_jacob(q)' *kc));
v_transpose = v';
ang= linspace(0, 360,360)/180*pi;
unit_circle_x = 1 * cos(ang);
unit_circle_y = 1 * sin(ang);

ellpsoid = u * s * v_transpose(:,[1,2]) * [unit_circle_x;unit_circle_y];
plot(ellpsoid(1,:), ellpsoid(2,:), color);