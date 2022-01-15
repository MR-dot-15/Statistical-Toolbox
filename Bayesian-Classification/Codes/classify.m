function class = classify(feature, mu_val, s_val, priori)
dim = length(feature);
n = length(mu_val);

% len(mu_val) = len(s_val) = len(priori)

% defining the discriminant func
g = @(class_cond, priori) log(class_cond) + log(priori);

g_val = ones(1, n);
class = 1;
% to slice the sigma matrix bunch
pointer = 1;
for i = 1:n
    mu = mu_val(i, :);
    
    sigma = s_val(:, pointer:pointer+dim-1);
    pointer = pointer+dim;
    
    p = norm_mult(feature, mu, sigma);
    temp = g(p, priori(i));
    g_val(i) = temp;
    if i > 1
        if g_val(i)>g_val(i-1)
            class = i;
        elseif g_val(i) == g_val(i-1)
            class = 0;
        end
    end
end