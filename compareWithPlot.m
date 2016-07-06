%%%%%%%%%%%%%%%
% Compare original and computed signals
% n1 and n2 have to be declared, and experiment Data has to be
% computed before running this Script
%%%%%%%%%%%%%%%

icaplot('sumerror', signal, n1, decompose, n2, 0, 0, 'Error comparison', 'Original Source', 'Computed Source')