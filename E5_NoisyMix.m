clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% Now some noise to the mix -> even worse result.
% This might be the reason why our own recordings did not work: Hall, noisy
% microphones, etc.
%%%%%%%%%%%%%%%

[signal,mixedsig]=demosig();

noisyMix = addNoise(mixedsig, 1.0);

decompose = fastica(noisyMix);

[meanErrors, stdErrors] = matchAndEval(signal, decompose);
fprintf('Total mean error is %f, std deviation is %f\n', mean(meanErrors), mean(stdErrors));

icaplot('complot', signal, 0, 0, 0, 'Original Signals')
icaplot('complot', noisyMix, 0, 0, 0, 'Noisy mixed Signals')
icaplot('complot', decompose, 0, 0, 0, 'Decomposed Signals')