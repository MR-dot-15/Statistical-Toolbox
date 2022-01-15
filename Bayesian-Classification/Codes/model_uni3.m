function model_uni3(xy_lim, m1, m2, s, p)
[X1, Y1, Z1] = sphere(35);
[X2, Y2, Z2] = sphere(35);

% creating the first density plot
r = sqrt(s);
X1 = r*X1 + m1(1);
Y1 = r*Y1 + m1(2);
Z1 = r*Z1 + m1(3);

surf(X1, Y1, Z1, 'FaceColor',[1, 0, 0], ...
    'EdgeColor',[1, 0.6, 0.6]);
hold on;

% creating the second density plot
X2 = r*X2 + m2(1);
Y2 = r*Y2 + m2(2);
Z2 = r*Z2 + m2(3);

surf(X2, Y2, Z2, 'FaceColor',[0, 0, 1], ...
    'EdgeColor',[0.6, 0.6, 1]);

% constructing the boundary plane
x0 = (m1 + m2)./2 - ...
    (m1 - m2)*s^2*log(p(1)/p(2))/norm((m1 - m2))^2;
w = (m1 - m2);
f_z = @(x,y, w_val, x0_val)(dot(w_val, x0_val)...
    - w_val(1)*x - w_val(2)*y)/w_val(3);
arr = xy_lim(1):0.7:xy_lim(2);
len = length(arr);
[X, Y] = meshgrid(arr);

Z = zeros(len, len);
for i = 1:len
    for j = 1:len
        Z(j, i) = f_z(arr(i), arr(j), w, x0);
    end
end
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'k');

xlim(xy_lim); ylim(xy_lim); zlim(xy_lim);
axis equal;

zlabel("x_3");
xlabel("x_1");
ylabel("x_2");
%title("Classifier with \Sigma = \sigma^2 I");
hold off;