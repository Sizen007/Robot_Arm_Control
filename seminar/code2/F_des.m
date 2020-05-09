function [F_des1] = F_des(n)
global kc;
global m;

for j = 1:n
      theta(j) =  pi/(n/2)*(j-1);
    for i = 1:m
        x(j,i) =   0.01*i*cos(theta(j));
        y(j,i) =   0.002*i*sin(theta(j));
    end
end

for i = 1:n
    F_des1(:,:,i) = kc*[x(i,:);y(i,:)]; 
end

end

