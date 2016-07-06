clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');
    
    
[signal(1,:), fs] = audioread('source3.wav')
[signal(2,:), fs] = audioread('source7.wav');

% Mix signals
mixmat = rand(size(signal,1));
mixedsig = mixmat * signal;

[decompose,mapping] = compute_mapping(mixedsig', 'PCA', 2);

decompose = decompose';
source1 = decompose(1,:);
source2 = decompose(2,:);

norm1 = source1/10;
norm2 = source2/10;

% Time scale (x axis)
t = [1/fs:1/fs:length(norm1)/fs];

icaplot('complot', signal, 0, 0, 0, 'Original Signals')
icaplot('complot', mixedsig, 0, 0, 0, 'Mixed Signals')
icaplot('complot', decompose, 0, 0, 0, 'Decomposed Signals')