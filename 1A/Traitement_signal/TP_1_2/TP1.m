clc
clear all
close all

N=90;
fe1=10000;
fe2=1000;
f0=1100;
Zp=nextpow2(N);

temps1 = [0: 1/fe1: (N-1)*(1/fe1)];
temps2 = [0: 1/fe2: (N-1)*(1/fe2)];

fft1=fft(cos(2*pi*f0*temps1));
%fft3=fft(cos(2*pi*f0*temps1), 2^Zp);
%fft2=fft(cos(2*pi*f0*temps2));

x=cos(2*pi*f0*temps1);
f1=linspace(0, fe1, N);
Auto_cor=conv(x, conj(flip(x)))/N;
Correlogramme = fft(Auto_cor);
period= periodogram(x);

%f2=linspace(0, fe2, N);
%f3=linspace(0, fe1, 2^Zp);

%figure,semilogy(f1, abs(fft1), f3, abs(fft3));
%legend('original', 'N=20', 'location', 'north');
%figure,semilogy(f3, abs(fft3));
%figure,semilogy(f2, abs(fft2));

plot(period);

xlabel('f (Hz)');
ylabel('DSP');
