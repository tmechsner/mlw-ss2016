clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% Now we add some noise to the original sources before mixing them
% -> not so good result.
%%%%%%%%%%%%%%%

[signal,mixedsig]=demosig();

noisySignal = addNoise(signal, 1.0);
mixmat = rand(size(signal,1));
mixedNoisySignals = mixmat * noisySignal;

decompose = fastica(mixedNoisySignals);

icaplot('complot', noisySignal, 0, 0, 0, 'Original noisy Signals')
icaplot('complot', mixedNoisySignals, 0, 0, 0, 'Mixed noisy Signals')
icaplot('complot', decompose, 0, 0, 0, 'Decomposed Signals')

[meanErrors, stdErrors] = matchAndEval(signal, decompose);
fprintf('Total mean error is %f, std deviation is %f\n', mean(meanErrors), mean(stdErrors));
