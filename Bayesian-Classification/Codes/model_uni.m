function model_uni(xy_lim, m1, s1, m2, s2, p)
arr = xy_lim(1):0.1:xy_lim(2);
%-10:0.1:10;
len = length(arr);
[X, Y] = meshgrid(arr);
sigma = sqrt(s1(1));

% plotting the gaussian
z1 = zeros(len, len);
z2 = zeros(len, len);
for i = 1:len
    for j = 1:len
        vector = [arr(i) arr(j)];
        z1(j, i) = norm_mult(vector,...
            m1, s1);
        z2(j, i) = norm_mult(vector,...
            m2, s2);
    end
end

% TO BE EDITED -----s
rot = [0 -1; 1 0];
x0 = (m1 + m2)./2 - ...
    (m1 - m2)*sigma^2*log(p(1)/p(2))/norm((m1 - m2))^2;
v = rot * (m2-m1)';
boundary_x = x0(1).*ones(1, len) + v(1).*arr;
boundary_y = x0(2).*ones(1, len) + v(2).*arr;

surf(X, Y, z1, 'FaceColor',[1, 0, 0], ...
    'EdgeColor',[1, 0.6, 0.6]);
hold on;
surf(X, Y, z2, 'FaceColor',[0, 0, 1], ...
    'EdgeColor',[0.6, 0.6, 1]);
plot3(boundary_x, boundary_y, -0.03.*ones(1, len), '-.k');

draw_circ(m1, sigma, 'r');
draw_circ(m2, sigma, 'b');

zlim([-0.03 inf]);
xlim(xy_lim); ylim(xy_lim);

zlabel("p(x|w_i)");
xlabel("x_1");
ylabel("x_2");
title("Classifier with \Sigma = \sigma^2 I");
%hold off;