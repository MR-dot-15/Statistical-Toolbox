function iris_pca()

% access and prepare data
data = readmatrix('iris.csv');
sep_len = data(:,1);
sep_wid = data(:,2);
pet_len = data(:,3);
pet_wid = data(:,4);

% centering
sep_len = (sep_len - mean(sep_len))/...
                            std(sep_len);
sep_wid = (sep_wid - mean(sep_wid))/...
                            std(sep_wid);
pet_len = (pet_len- mean(pet_len))/...
                            std(pet_len);
pet_wid = (pet_wid - mean(pet_wid))/...
                            std(pet_wid);
dat = horzcat(sep_len,...
              sep_wid,...
              pet_len,...
              pet_wid);

% cov matrix and PA est
sigma = cov(dat);
PA = est_ld(sigma);
PA = PA(:,1:2);

% "rotating" the data to project 
% onto the PA_i basis
rot_dat = PA' * dat';

% scatter
scatter(rot_dat(1,1:50), rot_dat(2,1:50), 'filled');
hold on;
scatter(rot_dat(1,51:100), rot_dat(2,51:100), 'filled');
scatter(rot_dat(1,101:end), rot_dat(2,101:end), 'filled');
xlabel('PA_1'); ylabel('PC_2')
legend(["Setosa", "Versicolor", "Virginica"]);
grid('on');