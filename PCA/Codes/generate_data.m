function data = generate_data(n, mu, sigma)
d = length(mu);
u = randn(n, d);
L = chol(sigma);
data = mu .* ones(n, d) + u * L;