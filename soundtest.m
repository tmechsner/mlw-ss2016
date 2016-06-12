clear;
addpath('fastica');

%Read Audiofiles 
[Y, fs] = audioread('source3.wav')
[X, fs] = audioread('source7.wav');

%
t = [1/fs:1/fs:length(Y)/fs];

newSound1 = 0.5*X' + 0.5*Y';
newSound2 = 0.65*X' + 0.35*Y';

for i=1:50000 signal(1,i)=newSound1(i); end
for i=1:50000 signal(2,i)=newSound2(i); end

decompose = fastica(signal);

source1 = decompose(1,:);
source2 = decompose(2,:);

% source1 = source1;
% source2 = source2;

norm1 = source1/10;
norm2 = source2/10;

figure
subplot(3,2,1)
 plot(t, signal(1, :))
 ylim([-1 1])
 xlim([0 6])
 title('Mixed sources 1')
subplot(3,2,2)
 plot(t, signal(2, :))
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
 plot(t, Y)
 ylim([-1 1])
 xlim([0 6])
 title('Original source 1')
subplot(3,2,6)
 plot(t, X)
 ylim([-1 1])
 xlim([0 6])
 title('Original source 2')