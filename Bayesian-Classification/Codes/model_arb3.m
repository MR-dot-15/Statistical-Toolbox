function model_arb3(xy_lim, m1, m2, sigma, p)
[x, y, z] = sphere(15);
L = chol(sigma);
len = 16*16;
x1 = zeros(16, 16);
y1 = zeros(16, 16);
z1 = zeros(16, 16);

% creating the first density plot
for i = 1:len
    for j = 1:len
        for k = 1:len
            vec = [x(i) y(j) z(k)];
            transformed_vec = m1.*ones(1,3) + vec*L;
            x1(i) = transformed_vec(1);
            y1(j) = transformed_vec(2);
            z1(k) = transformed_vec(3);
        end
    end
end

surf(x1, y1, z1, 'FaceColor',[1, 0, 0], ...
    'EdgeColor',[1, 0.6, 0.6]);
hold on;

% creating the second density plot
x2 = zeros(16, 16);
y2 = zeros(16, 16);
z2 = zeros(16, 16);

for i = 1:len
    for j = 1:len
        for k = 1:len
            vec = [x(i) y(j) z(k)];
            transformed_vec = m2.*ones(1,3) + vec*L;
            x2(i) = transformed_vec(1);
            y2(j) = transformed_vec(2);
            z2(k) = transformed_vec(3);
        end
    end
end

surf(x2, y2, z2, 'FaceColor',[0, 0, 1], ...
    'EdgeColor',[0.6, 0.6, 1]);

% constructing the boundary plane
r = (m1 - m2)*(inv(sigma)*(m1 - m2)');
x0 = (m1 + m2)./2 - ...
    (m1 - m2)*log(p(1)/p(2))/r;
w = inv(sigma) * (m1 - m2)';
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