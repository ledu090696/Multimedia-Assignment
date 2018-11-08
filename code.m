% Tao giai dieu cho audio dau vao
fs = 44100; % tan so phat
t = 0 : 1/fs : 0.3; % thoi gian phat

fdoo = 528; % tan so cua cac not nhac
fsi = 495;
fla = 440;
fsol = 396;
ffa = 352;
fmi = 330;
fre = 293;
fdo = 264;

A0 = .7;A1 = .6; A2 = .5; A3 = .4; A4 = .3; A5 = .2; A6 = .1;   % bien do

w = 0; % pha

doo = A6 *sin( 2 * pi * fdoo * t + w ); % cau hinh cac not nhac
si = A0 *sin( 2 * pi * fsi * t + w );
la = A1 *sin( 2 * pi * fla * t + w );
sol = A2 *sin( 2 * pi * fsol * t + w );
fa = A3 *sin( 2 * pi * ffa * t + w );
mi = A4 *sin( 2 * pi * fmi * t + w );
re = A5 *sin( 2 * pi * fre * t + w );
do = A6 *sin( 2 * pi * fdo * t + w );
% tao giai dieu
y = [si si la la sol fa fa mi mi re re doo la la sol sol sol la la si si doo doo doo si si la la sol fa fa mi mi re re do doo doo si si la la sol sol sol la la si si doo];
Input = audioread('orig_input.wav'); % doc file dau vao
x1 = Input';
x2 = x1(1:length(y)); % chieu dai cua dau vao va melody bang nhau
melody = y+x2; % them giai dieu
audiowrite('melody.wav',melody',44100); % ghi file
%fft
[x,fs]=audioread('melody.wav');
Y = fft(x);
figure (1);
plot(abs(Y));
N = fs; % number of FFT points
transform = fft(y,N)/N;
magTransform = abs(transform);
faxis = linspace(-fs/2,fs/2,N);
figure (2);
plot(faxis,fftshift(magTransform));
xlabel('Frequency (Hz)');

% Tao spectogram cho tin hieu
subplot(2,1,2);
win = 128;
hop = win/2;            
nfft = win;
figure (3);
spectrogram(melody,win,hop,nfft,fs,'yaxis');
title('Spectogram(melody)');
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt));