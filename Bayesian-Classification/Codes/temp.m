function temp()
m1 = [1 1 1];
m2 = [-1 -1 -1];
s = [2 1 1; 1 2 1; 1 1 2];
p = [0.5 0.5];

subplot(1, 2, 1)
model_arb3([-7 7], m1, m2, s, p);
subtitle("P = [0.5, 0.5]");

subplot(1, 2, 2)
p = [0.7 0.3];
model_arb3([-7 7], m1, m2, s, p);
subtitle("P = [0.7, 0.3]");