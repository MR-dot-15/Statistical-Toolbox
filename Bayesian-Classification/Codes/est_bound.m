function est_bound(arr, m1, m2, s1, s2, p, z_val)
n = length(arr);

boundary_x = []; boundary_y = [];

for i=2:2:n-1
    slc_x = arr(i-1:i+1);
    for j=2:2:n-1
        slc_y = arr(j-1:j+1);
        slc_x = [repmat(slc_x(1), 1, 3),...
            repmat(slc_x(2), 1, 3),...
            repmat(slc_x(3), 1, 3)];
        slc_y = repmat(slc_y, 1, 3);
        class = classify([arr(i) arr(j)],...
            [m1; m2], [s1 s2], p);
        if class == 0
            boundary_x = [boundary_x arr(i)];
            boundary_y = [boundary_y arr(j)];
            continue;
        end
        for vector = [slc_x; slc_y]
            neighb_class = classify(vector',...
                [m1; m2], [s1 s2], p);
            if neighb_class ~= class
                boundary_x = [boundary_x arr(i)];
                boundary_y = [boundary_y arr(j)];
                break;
            end
        end
    end
end
len = length(boundary_x);
scatter3(boundary_x, boundary_y, z_val.*ones(1,len), '.k');