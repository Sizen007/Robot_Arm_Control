function [] = plot_data(f, title_name, q_res, points_res)
global q_initial;
global points_initial;
figure(f)
title(title_name, 'FontSize',15);
xlabel('x');
ylabel('y');
line1 = line(points_initial(:,1), points_initial(:,2) );
line1.Marker = '.';
line1.MarkerSize = 30;
line1.Color = 'blue';
line2 = line(points_res(:,1), points_res(:,2) );
line2.Marker = '.';
line2.MarkerSize = 30;
line2.Color = 'red';
hold on;

ellpsoid1 = get_sfe(q_initial);
ellpsoid2 = get_sfe(q_res);
e1 = plot( ellpsoid1(1,:)+points_initial(5,1), ellpsoid1(2,:)+points_initial(5,2), 'b');
hold on;
e2=plot(ellpsoid2(1,:)+points_initial(5,1), ellpsoid2(2,:)+points_initial(5,2), 'r');
hold on;

sfr1 = get_sfr(q_initial);
s1 = plot(sfr1(:,1)+points_initial(5,1),sfr1(:,2)+points_initial(5,2),'b');
sfr2 = get_sfr(q_res);
s2 = plot(sfr2(:,1)+points_initial(5,1),sfr2(:,2)+points_initial(5,2),'r');

legend([e1 e2],{'origin','optimized'}, 'Location','northwest', 'FontSize',15);


end