function usArrest_dat_anal()
% define colors uwu
bg = [40/255, 40/255, 50/255];
scatter_face = [0.6, 0.6, 1];
scatter_edge = [0.8, 0.8, 0.8];
nred = [1, 0.5, 0.5];
ngrn = [0.5, 1, 0.5];
nblu = [0.5, 0.5, 1];
axis_etc = [0.7, 0.7, 0.7];
% -----------------

% accessing the data-set
data = readmatrix('usarrest.csv');
data = data(:,2:end);

% preparing the data
murder = data(:,1);
assault = data(:,2);
urbpop = data(:,3);
rape = data(:,4);

% visualization
% s = 30;
% set(gcf, 'color', bg);
% scatter3(murder, assault, rape,...
%     s, scatter_face,...
%     'MarkerEdgeColor', scatter_edge,...
%     'MarkerFaceColor', 'flat');
% set(gcf,'InvertHardCopy','Off');
% grid(gca, 'on');
% xlabel('Arrested for murder (#/10^5)'); 
% ylabel('Arrested for assault (#/10^5)'); 
% zlabel('Arrested for rape (#/10^5)');
% hold off;
% set(gca, 'color', bg,...
%     'XColor', axis_etc,...
%     'YColor', axis_etc,...
%     'ZColor', axis_etc);

% pca calculation etc

% centering the data
murder = (murder - mean(murder))/std(murder);
assault = (assault - mean(assault))/std(assault);
urbpop = (urbpop - mean(urbpop))/std(urbpop);
rape = (rape - mean(rape))/std(rape);
rel_data = horzcat(murder,...
                    assault,...
                    urbpop,...
                    rape);

% cov matrix
sigma = cov(rel_data);
PA = est_pa(sigma);

% "rotating" the data to project 
% onto the PA_i basis
rotated_data = PA' * rel_data';
PCvar = [0 0 0 0];
for i = 1:4
    PCvar(i) = var(rotated_data(i,:));
end

% calculating the loads
X_murd = [std(murder) 0 0 0];
X_assl = [0 std(assault) 0 0];
X_urbp = [0 0 std(urbpop) 0];
X_rape = [0 0 0 std(rape)];
rot_feat = PA' * [X_murd',...
                  X_assl',...
                  X_urbp',...
                  X_rape'];
rot_feat1 = rot_feat(:,1);
rot_feat2 = rot_feat(:,2);
rot_feat3 = rot_feat(:,3);
rot_feat4 = rot_feat(:,4);

% visualization
s = 10;
set(gcf, 'color', bg);
set(gcf,'InvertHardCopy','Off');
scatter(rotated_data(1,:), rotated_data(2,:),...
    s, scatter_face,...
    'MarkerEdgeColor', scatter_edge,...
    'MarkerFaceColor','flat'); hold on;
quiver(0, 0, rot_feat1(1), rot_feat1(2),...
    0, 'Color', nred, 'ShowArrowHead', 'off',...
    'DisplayName', 'Murder');
quiver(0, 0, rot_feat2(1), rot_feat2(2),...
    0, 'Color', scatter_edge, 'ShowArrowHead', 'off',...
    'DisplayName', 'Assault');
quiver(0, 0, rot_feat3(1), rot_feat3(2),...
    0, 'Color', ngrn, 'ShowArrowHead', 'off',...
    'DisplayName', 'Urban pop');
quiver(0, 0, rot_feat4(1), rot_feat4(2),...
    0, 'Color', nblu, 'ShowArrowHead', 'off',...
    'DisplayName', 'Rape');
set(gca, 'color', bg,...
    'XColor', axis_etc,...
    'YColor', axis_etc);
legend();
xlabel('PC_1'); ylabel('PC_2');
grid('on');

disp(PCvar./4)