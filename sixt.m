clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% Lets go back to noisy signals and evaluate the noise - error relation
%%%%%%%%%%%%%%%

[signal,mixedsig]=demosig();
mixmat = rand(size(signal,1));

errors = ones(11,1);
stds = ones(11,1);
steps = ones(11,1);
for i = 0.0 : 0.5 : 5.0
    noisySignal = addNoise(signal, i);
    mixedNoisySignals = mixmat * noisySignal;

    decompose = fastica(mixedNoisySignals);

    [meanErrors, stdErrors] = matchAndEval(signal, decompose);
    errors(round(1 + i / 5 * 10)) = mean(meanErrors);
    stds(round(1 + i / 5 * 10)) = mean(stdErrors);
    steps(round(1 + i / 5 * 10)) = i;
    fprintf('Total mean error is %f, std deviation is %f\n', mean(meanErrors), mean(stdErrors));
end
figure
subplot(1,1,1)
    plot(steps, errors, steps, stds);
    title('Errors and standard deviations - signal noise rate');