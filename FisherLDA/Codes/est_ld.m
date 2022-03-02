function V = est_ld(X)
% find the eigenvals and vecs
[V, L] = eig(X);
% sort the eigenvals (ascend)
[~, ind] = sort(diag(L), 'descend');
% sort correspodning eigvecs
V = V(:, ind);