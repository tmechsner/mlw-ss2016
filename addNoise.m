function [noisySignal]=addNoise(signal, p)
%ADDNOISE Add noise to each row individually (limited to p times the unsigned mean of the row)

    noisySignal = ones(size(signal));
    for i = 1 : size(signal,1)
        noisySignal(i,:) = signal(i,:) + (rand(size(signal(i,:))) - 0.5) * p * 2.0 * mean(abs(signal(i,:)));
    end
end