%load iris 
load('data/Iris.mat');
addpath('drtoolbox');
addpath('drtoolbox/techniques');
%oder einfach ins Fenster ziehen

%PCA
[mappedX,mapping] = compute_mapping(Data, 'PCA');
figure;
scatter(mappedX(:,1),mappedX(:,2),20,Labels)
% plot(mappedX(1:50,1),mappedX(1:50,2),'g.');
% hold on
% plot(mappedX(51:100,1),mappedX(51:100,2),'b.');
% plot(mappedX(101:150,1),mappedX(101:150,2),'r.');
