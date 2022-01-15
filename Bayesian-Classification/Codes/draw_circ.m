function draw_circ(center, r, LineSpec)
f = center(1); g = center(2);
theta = 0:0.01:2*pi;
x_r = r*cos(theta);
y_r = r*sin(theta);
z = -0.03 * ones(1, length(theta));

plot3(f + x_r, g + y_r, z, LineSpec);