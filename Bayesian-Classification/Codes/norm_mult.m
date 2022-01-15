function val = norm_mult(x, mu, sigma)
d = length(x);
coeff = 1/((2*pi)^(d/2)*det(sigma));
mat = exp(-((x-mu)*(inv(sigma)*(x-mu)'))/2);
val = coeff * mat;