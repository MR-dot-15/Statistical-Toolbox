function model_arb(xy_lim, m1, m2, s1, s2, p)
arr = xy_lim(1):0.1:xy_lim(2);
%-10:0.1:10;
len = length(arr);
[X, Y] = meshgrid(arr);

% constructing the boundary plane
% r = (m1 - m2)*(inv(sigma)*(m1 - m2)');
% x0 = (m1 + m2)./2 - ...
%     (m1 - m2)*log(p(1)/p(2))/r;
% w = inv(sigma) * (m1 - m2)';
% f_y = @(x, w_val, x0_val)(dot(w_val, x0_val)...
%     - w_val(1)*x)/w_val(2);

% calculating the gaussian
z1 = zeros(len, len);
z2 = zeros(len, len);
for i = 1:len
    for j = 1:len
        vector = [arr(i) arr(j)];
        z1(j, i) = 0.05 + norm_mult(vector,...
            m1, s1);
        z2(j, i) = 0.05 + norm_mult(vector,...
            m2, s2);
    end
end

% first gaussian
surf(X, Y, z1, 'FaceColor',[1, 0, 0], ...
    'EdgeColor',[1, 0.6, 0.6]); hold on;
% second gaussian
surf(X, Y, z2, 'FaceColor',[0, 0, 1], ...
    'EdgeColor',[0.6, 0.6, 1]);
% contour
contour(X, Y, z1, 'r', 'LineWidth', 0.1);
contour(X, Y, z2, 'b', 'LineWidth', 0.1);

% boundary
% Y = zeros(1,len);
% for i = 1:len
%     Y(i) = f_y(arr(i), w, x0);
% end
% plot3(arr, Y, zeros(1,len), '--k');

% the alternative boundary
arr = xy_lim(1):0.03:xy_lim(2);
est_bound(arr, m1, m2, s1, s2, p, 0);

%hold off;

xlim(xy_lim); ylim(xy_lim);

zticks(0:0.05:1.1);
zticklabels({'0', '0.05', '0.1', '1.05', '1.1'});

zlabel("p(x|w_i)");
xlabel("x_1");
ylabel("x_2");
%title("Classifier with \Sigma_i = \Sigma");