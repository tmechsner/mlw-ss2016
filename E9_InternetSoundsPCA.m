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

source1 = decompose(1,:);
source2 = decompose(2,:);

norm1 = source1/10;
norm2 = source2/10;

% Time scale (x axis)
t = [1/fs:1/fs:length(norm1)/fs];

icaplot('complot', signal, 0, 0, 0, 'Original Signals')
icaplot('complot', mixedsig, 0, 0, 0, 'Mixed Signals')
icaplot('complot', decompose', 0, 0, 0, 'Decomposed Signals')

prompt = {'Enter signal number:','Enter source number:'};
dlg_title = 'Signal / Input comparison';
num_lines = 1;

pause;
answer = inputdlg(prompt,dlg_title,num_lines);
n1 = str2num(answer{1});
n2 = str2num(answer{2});

while n1 > 0
    icaplot('sumerror', signal, n1, decompose', n2, 0, 0, 'Comparison')
    pause;

    answer = inputdlg(prompt,dlg_title,num_lines);
    n1 = str2num(answer{1});
    n2 = str2num(answer{2});
end