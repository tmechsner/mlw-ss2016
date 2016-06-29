function [ meanErrors, stdErrors ] = matchAndEval( signal, decompose )
%MATCHANDEVAL Match signals by minimal mean and return means and std
%deviation of all matches.
    n = size(signal,1);
    meanErrors = ones(n,1);
    stdErrors = ones(n,1);
    for j = 1 : n
        meanError = Inf;
        stdError = Inf;
        matchIndex = 0;
        for i = 1 : n
            % Test signal
            error = abs(signal(j,:) - decompose(i,:));
            tmpMean = mean(error);
            if meanError > tmpMean
                meanError = tmpMean;
                stdError = std(error);
                matchIndex = i;
            end
            meanError = min(meanError,mean(error));
            stdError = min(stdError,std(error));

            % Test inverted signal as well
            error = abs(signal(j,:) + decompose(i,:));
            tmpMean = mean(error);
            if meanError > tmpMean
                meanError = tmpMean;
                stdError = std(error);
                matchIndex = i;
            end
        end
        fprintf('%d matches with %d, mean error is %f, std error is %f \n', j, matchIndex, meanError, stdError);
        meanErrors(j) = meanError;
        stdErrors(j) = stdError;
    end
end

