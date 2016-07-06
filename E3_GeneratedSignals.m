clear; clc; close all;
addpath('fastica');
addpath('drtoolbox');
addpath('drtoolbox/techniques');

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