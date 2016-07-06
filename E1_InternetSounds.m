clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% Soundfiles as demonstrated in the lecture
%%%%%%%%%%%%%%%

%Read Audiofiles 
[signal(1,:), fs] = audioread('source3.wav')
[signal(2,:), fs] = audioread('source7.wav');

% Mix signals
mixmat = rand(size(signal,1));
mixedsig = mixmat * signal;

decompose = fastica(mixedsig);

source1 = decompose(1,:);
source2 = decompose(2,:);

norm1 = source1/10;
norm2 = source2/10;

% Time scale (x axis)
t = [1/fs:1/fs:length(norm1)/fs];

figure
subplot(3,2,1)
 plot(t, mixedsig(1, :))
 ylim([-1 1])
 xlim([0 6])
 title('Mixed sources 1')
subplot(3,2,2)
 plot(t, mixedsig(2, :))
 ylim([-1 1])
 xlim([0 6])
 title('Mixed sources 2')
subplot(3,2,3)
 plot(t, norm1)
 ylim([-1 1])
 xlim([0 6])
 title('Computed source 1')
subplot(3,2,4)
 plot(t, norm2)
 ylim([-1 1])
 xlim([0 6])
 title('Computed source 2')
subplot(3,2,5)
 plot(t, signal(1,:))
 ylim([-1 1])
 xlim([0 6])
 title('Original source 1')
subplot(3,2,6)
 plot(t, signal(2,:))
 ylim([-1 1])
 xlim([0 6])
 title('Original source 2')