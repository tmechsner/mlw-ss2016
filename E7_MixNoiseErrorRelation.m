clear; clc;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

%%%%%%%%%%%%%%%
% And the same for a noisy mix
%%%%%%%%%%%%%%%

[signal,mixedsig]=demosig();
mixmat = rand(size(signal,1));

errors = ones(11,1);
stds = ones(11,1);
steps = ones(11,1);
for i = 0.0 : 0.5 : 5.0
    mixedSignals = mixmat * signal;
    noisyMix = addNoise(mixedSignals, i);

    decompose = fastica(noisyMix);

    [meanErrors, stdErrors] = matchAndEval(signal, decompose);
    errors(round(1 + i / 5 * 10)) = mean(meanErrors);
    stds(round(1 + i / 5 * 10)) = mean(stdErrors);
    steps(round(1 + i / 5 * 10)) = i;
    fprintf('Total mean error is %f, std deviation is %f\n', mean(meanErrors), mean(stdErrors));
end
figure
subplot(1,1,1)
    plot(steps, errors, steps, stds);
    title('Errors and standard deviations - mix noise rate');