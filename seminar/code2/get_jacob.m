function [jacob_matrix] = get_jacob(q)
    global l1;
    global l2;
    global l3;
    global l4;

    o0 = [0;0;0];
    o1 = [l1*cos(q(1));
             l1*sin(q(1));
             0];
     
    o2 = [l1*cos(q(1))+l2*cos(q(1)+q(2));
              l1*sin(q(1))+l2*sin(q(1)+q(2)); 
              0];
     
    o3 = [l1*cos(q(1))+l2*cos(q(1)+q(2))+l3*cos(q(1)+q(2)+q(3));
              l1*sin(q(1))+l2*sin(q(1)+q(2))+l3*sin(q(1)+q(2)+q(3)); 
              0];
     
    o4 = [l1*cos(q(1))+l2*cos(q(1)+q(2))+l3*cos(q(1)+q(2)+q(3))+l4*cos(q(1)+q(2)+q(3)+q(4));
              l1*sin(q(1))+l2*sin(q(1)+q(2))+l3*sin(q(1)+q(2)+q(3))+l4*sin(q(1)+q(2)+q(3)+q(4)); 
             0];
    z0=[0;0;1];
    z1=[0;0;1];
    z2=[0;0;1];
    z3=[0;0;1];
    
    j = [cross(z0, (o4-o0)),  cross(z1, (o4-o1)), cross(z2, (o4-o2)), cross(z3, (o4-o3)); 
                                                     z0,                         z1,                        z2,                       z3];
                                                 
    jacob_matrix = j([1,2], :);
end