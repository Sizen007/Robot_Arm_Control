function [H, joints_position]= forward_kine(q)
global l1;
global l2;
global l3;
global l4;
A0_1 = [cos(q(1)),  -sin(q(1)),  0,   l1*cos(q(1));
              sin(q(1)),   cos(q(1)),  0,   l1*sin(q(1));
                         0,              0,  1,                  0;
                         0,              0,  0,                  1];
                     
A1_2 =  [cos(q(2)),  -sin(q(2)),  0,   l2*cos(q(2));
               sin(q(2)),   cos(q(2)),  0,   l2*sin(q(2));
                          0,             0,   1,                  0;
                          0,             0,   0,                  1];
                     
A2_3 =  [cos(q(3)),  -sin(q(3)),  0,   l3*cos(q(3));
               sin(q(3)),   cos(q(3)),  0,   l3*sin(q(3));
                         0,              0,   1,                   0;
                         0,              0,   0,                   1];
A3_4 = [cos(q(4)) , -sin(q(4)),  0,   l4*cos(q(4));
              sin(q(4)),   cos(q(4)),  0,   l4*sin(q(4));
                         0,              0,  1,                   0;
                         0,              0,  0,                   1];
                     
H = A0_1 * A1_2 * A2_3 * A3_4;
joint0 = [0,0];

joint1 = A0_1;
joint1 = joint1([1,2], 4)';

joint2 = A0_1 * A1_2;
joint2 = joint2([1,2], 4)';

joint3 = A0_1 * A1_2 * A2_3;
joint3 = joint3([1,2], 4)';

joint4 = A0_1 * A1_2 * A2_3 * A3_4;
joint4 = joint4([1,2], 4)';
joints_position = [joint0; joint1; joint2; joint3; joint4];

end