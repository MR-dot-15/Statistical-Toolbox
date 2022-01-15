function accuracy = arb_examp()
% class 1, P = 0.5
s = [2 1; 1 2];
m1 = [1 1]; s1 = s;
data1 = generate_data(100, m1, s1);
% class 2, P = 0.5
m2 = [-1 -1]; s2 = s;
data2 = generate_data(100, m2, s2);

%training
mu1 = mean(data1(1:50, :));
sigma1 = cov(data1(1:50, :));

mu2 = mean(data2(1:50, :));
sigma2 = cov(data2(1:50, :));

mu = [mu1; mu2];
sigma = horzcat(sigma1, sigma2);
priori = [0.5 0.5];

count = 0;
for i=51:100
    class = classify(data1(i, :), mu, sigma, priori);
    if class == 1
        count = count + 1;
    end
end
for i=51:100
    class = classify(data2(i, :), mu, sigma, priori);
    if class == 2
        count = count + 1;
    end
end
accuracy = count/100;

subplot(1,2,1)
model_arb([-7 7], mu1, mu2, (sigma1 + sigma2)./2, priori);
for i = 51:100
    scatter3(data1(i, 1), data1(i, 2), 0, '.r')
    scatter3(data2(i, 1), data2(i, 2), 0, '.b')
end
subtitle("P = [0.5, 0.5]");

subplot(1,2,2)
priori = [0.7 0.3];
model_arb([-7 7], mu1, mu2, (sigma1 + sigma2)./2, priori);
for i = 51:100
    scatter3(data1(i, 1), data1(i, 2), 0, '.r')
    scatter3(data2(i, 1), data2(i, 2), 0, '.b')
end
subtitle("P = [0.7, 0.3]");