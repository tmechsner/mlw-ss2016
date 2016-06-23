function [noisySignal]=addNoise(signal, p)

    noisySignal = ones(size(signal));
    for i = 1 : size(signal,1)
        % Add noise (limited to 0.5 times the unsigned mean)
        noisySignal(i,:) = signal(i,:) + (rand(size(signal(i,:))) - 0.5) * p * 2.0 * mean(abs(signal(i,:)));
    end
end