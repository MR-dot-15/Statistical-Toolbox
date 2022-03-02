function anal_iris()

% access and prepare data
data = readmatrix('iris.csv');
sep_len = data(:,1);
sep_wid = data(:,2);
pet_len = data(:,3);
pet_wid = data(:,4);

% scatter ----
% scatter3(sep_len(1:50), sep_wid(1:50),pet_len(1:50),'filled');
% hold on;
% scatter3(sep_len(51:100), sep_wid(51:100),pet_len(51:100),'filled');
% scatter3(sep_len(101:end), sep_wid(101:end),pet_len(101:end),'filled');
% xlabel("Sepal length");
% ylabel("Sepal width");
% zlabel("Petal length");
% legend(["Setosa", "Versicolor", "Virginica"])

% class-wise data sets (with all 4 params)
set = horzcat(sep_len(1:50),...
                  sep_wid(1:50),...
                  pet_len(1:50),...
                  pet_wid(1:50));
vers = horzcat(sep_len(51:100),...
                  sep_wid(51:100),...
                  pet_len(51:100),...
                  pet_wid(51:100));
virgin = horzcat(sep_len(101:end),...
                  sep_wid(101:end),...
                  pet_len(101:end),...
                  pet_wid(101:end));

% class means (mu_i)
m_set = mean(set);
m_vers = mean(vers);
m_vir = mean(virgin);

% overall mean (mu)
m = mean([m_set; m_vers; m_vir]);

% between class scatter
SB = 50*((m_set-m)'*(m_set-m) +...
         (m_vers-m)'*(m_vers-m) +...
         (m_vir-m)'*(m_vir-m));

% within class scatter
SW = zeros(4);
for i = 1:150
    if i<51
        x = set(i,:);
        SW = SW + (x-m_set)'*(x-m_set);
    elseif i<101
        x = vers(i-50,:);
        SW = SW + (x-m_vers)'*(x-m_vers);
    else
        x = set(i-100,:);
        SW = SW + (x-m_vir)'*(x-m_vir);
    end
end

% eigen calculation
% eigenvectors corresponding to the maximum eigenvals
% of SW^-1 SB
w = est_ld(SW\SB);
w = w(:,1:2)';

% projection on the LD-s
y_set = w*set';
y_vers = w*vers';
y_vir = w*virgin';

% LDA scatter 
scatter(y_set(1,:), y_set(2,:), 'filled'); hold on;
scatter(y_vers(1,:), y_vers(2,:), 'filled');
scatter(y_vir(1,:), y_vir(2,:), 'filled');
xlabel("LD_1"); ylabel("LD_2");
legend(["Setosa", "Versicolor", "Virginica"]);
grid('on');