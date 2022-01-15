function accuracy = uv_example()
% class 1, P = 0.5
s = 2.5.*eye(2);
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
priori = [0.6 0.4];

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
model_uni([-7 7], mu1, s, mu2, s, priori);
for i = 51:100
    scatter3(data1(i, 1), data1(i, 2), -0.03, '.r')
    scatter3(data2(i, 1), data2(i, 2), -0.03, '.b')
end
