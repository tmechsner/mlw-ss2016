clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%

[signal,mixedsig]=demosig();

mixedsig(1,:) = (mixedsig(1,:) - mean(mixedsig(1,:))) / std(mixedsig(1,:));
mixedsig(2,:) = (mixedsig(2,:) - mean(mixedsig(2,:))) / std(mixedsig(2,:));
mixedsig(3,:) = (mixedsig(3,:) - mean(mixedsig(3,:))) / std(mixedsig(3,:));
mixedsig(4,:) = (mixedsig(4,:) - mean(mixedsig(4,:))) / std(mixedsig(4,:));

[decompose,mapping] = compute_mapping(mixedsig', 'PCA', 4);

icaplot('complot', signal, 0, 0, 0, 'Original Signals')
icaplot('complot', mixedsig, 0, 0, 0, 'Mixed Signals')
icaplot('complot', decompose', 0, 0, 0, 'Decomposed Signals')

prompt = {'Enter signal number:','Enter source number:'};
dlg_title = 'Signal / Input comparison';
num_lines = 1;
