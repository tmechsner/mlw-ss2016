clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% Here we generate 4 sources, mix them and run pca.
% We can compare the result to the results of experiment 3
%%%%%%%%%%%%%%%

[signal,mixedsig]=demosig();

mixedsig(1,:) = (mixedsig(1,:) - mean(mixedsig(1,:))) / std(mixedsig(1,:));
mixedsig(2,:) = (mixedsig(2,:) - mean(mixedsig(2,:))) / std(mixedsig(2,:));
mixedsig(3,:) = (mixedsig(3,:) - mean(mixedsig(3,:))) / std(mixedsig(3,:));
mixedsig(4,:) = (mixedsig(4,:) - mean(mixedsig(4,:))) / std(mixedsig(4,:));

[decompose,mapping] = compute_mapping(mixedsig', 'PCA', 4);
decompose = decompose';

icaplot('complot', signal, 0, 0, 0, 'Original Signals')
icaplot('complot', mixedsig, 0, 0, 0, 'Mixed Signals')
icaplot('complot', decompose, 0, 0, 0, 'Decomposed Signals')