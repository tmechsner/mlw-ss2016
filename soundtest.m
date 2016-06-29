function soundtest(execExperiments)

clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

if(ismember(1,execExperiments))
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
    
    prompt = {'Enter signal number:','Enter source number:'};
    dlg_title = 'Signal / Input comparison';
    num_lines = 1;
    
    pause;
    answer = inputdlg(prompt,dlg_title,num_lines);
        n1 = str2num(answer{1});
        n2 = str2num(answer{2});
    
    while n1 > 0
        icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Error comparison')
        pause;

        answer = inputdlg(prompt,dlg_title,num_lines);
        n1 = str2num(answer{1});
        n2 = str2num(answer{2});
    end
    
    close all;
end


if(ismember(2,execExperiments))
    %%%%%%%%%%%%%%%
    % Next we tried live recorded sounds
    %%%%%%%%%%%%%%%

    clear signal;
    
    %Read Audiofiles 
    [signal(1,:), fs] = audioread('live_source1_mono.wav');
    [signal(2,:), fs] = audioread('live_source2_mono.wav');

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

    pause;

    sound(norm1, fs);
    pause;

    close all;
end

if(ismember(3,execExperiments))
    %%%%%%%%%%%%%%%
    % As this did not work we now use generated Signals because they can be inspected more easily
    %%%%%%%%%%%%%%%

    [signal,mixedsig]=demosig();

    decompose = fastica(mixedsig);

     icaplot('complot', signal, 0, 0, 0, 'Original Signals')
     icaplot('complot', mixedsig, 0, 0, 0, 'Mixed Signals')
     icaplot('complot', decompose, 0, 0, 0, 'Decomposed Signals')
    
     prompt = {'Enter signal number:','Enter source number:'};
    dlg_title = 'Signal / Input comparison';
    num_lines = 1;
    
    [meanErrors, stdErrors] = matchAndEval(signal, decompose);
    fprintf('Total mean error is %f, std deviation is %f\n', mean(meanErrors), mean(stdErrors));
    
    pause;
    %answer = inputdlg(prompt,dlg_title,num_lines);
    %    n1 = str2num(answer{1});
    %    n2 = str2num(answer{2});
    
    %while n1 > 0
    %    icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Comparison')
    %    pause;
    %    answer = inputdlg(prompt,dlg_title,num_lines);
    %    n1 = str2num(answer{1});
    %    n2 = str2num(answer{2});
    %end
    
    close all;
end

if(ismember(4,execExperiments))
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
        
    pause;
    
%     prompt = {'Enter signal number:','Enter source number:'};
%     dlg_title = 'Signal / Input comparison';
%     num_lines = 1;
%     answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     while n1 > 0
%         icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Comparison')
%         pause;
% 
%         answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     end

    close all;
end

if(ismember(5,execExperiments))
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
    
    pause;
    
%     prompt = {'Enter signal number:','Enter source number:'};
%     dlg_title = 'Signal / Input comparison';
%     num_lines = 1;
%     answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     
%     while n1 > 0
%         icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Comparison')
%         pause;
% 
%         answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     end
    
    close all;
end

if(ismember(6,execExperiments))
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
    figure;
    title('Errors and standard deviations - signal noise rate');
    plot(steps, errors, steps, stds);
        
%     answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     while n1 > 0
%         icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Comparison')
%         pause;
% 
%         answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     end

end

if(ismember(7,execExperiments))
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
    figure;
    title('Errors and standard deviations - mix noise rate');
    plot(steps, errors, steps, stds);
        
    pause;
%     answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     while n1 > 0
%         icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Comparison')
%         pause;
% 
%         answer = inputdlg(prompt,dlg_title,num_lines);
%         n1 = str2num(answer{1});
%         n2 = str2num(answer{2});
%     end

    close all;
end

if(ismember(8,execExperiments))
    %%%%%%%%%%%%%%%
    % 
    %%%%%%%%%%%%%%%

    [signal,mixedsig]=demosig();
    
    mixedsig(1,:) = (mixedsig(1,:) - mean(mixedsig(1,:))) / std(mixedsig(1,:));
    mixedsig(2,:) = (mixedsig(2,:) - mean(mixedsig(2,:))) / std(mixedsig(2,:));
    mixedsig(3,:) = (mixedsig(3,:) - mean(mixedsig(3,:))) / std(mixedsig(3,:));
    mixedsig(4,:) = (mixedsig(4,:) - mean(mixedsig(4,:))) / std(mixedsig(4,:));
    
    [decompose,mapping] = compute_mapping(mixedsig', 'PCA', 4);

    icaplot('complot', signal, 0, 0, 0, 'Original Signals')
    icaplot('complot', mixedsig, 0, 0, 0, 'Mixed Signals')
    icaplot('complot', decompose', 0, 0, 0, 'Decomposed Signals')

    prompt = {'Enter signal number:','Enter source number:'};
    dlg_title = 'Signal / Input comparison';
    num_lines = 1;
    
    pause;
    %answer = inputdlg(prompt,dlg_title,num_lines);
    %    n1 = str2num(answer{1});
    %    n2 = str2num(answer{2});
    
    %while n1 > 0
    %    icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Comparison')
    %    pause;
%
 %       answer = inputdlg(prompt,dlg_title,num_lines);
  %      n1 = str2num(answer{1});
   %     n2 = str2num(answer{2});
    %end
    
    close all;
    
end
    
if(ismember(9,execExperiments))
    
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
    
    close all;
    
end