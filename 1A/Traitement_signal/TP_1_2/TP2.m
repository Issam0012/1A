clc
clear all
close all

N=100;
f1=1000;
f2=3000;
fe=10000;

temps = [0: 1/fe: (N-1)*(1/fe)];
signal = cos (2*pi*f1*temps) + cos(2*pi*f2*temps);
f=linspace(0,fe,N);

k = linspace(-N,N, 2*N+1);
k1 = linspace(-11/2,11/2, 12);
k2 = linspace(-61/2,61/2, 62);
fc=1500;

h = 2 * fc/fe * sinc(2 * fc/fe * k);
h1 = 2 * fc/fe * sinc(2 * fc/fe * k1);
h2 = 2 * fc/fe * sinc(2 * fc/fe * k2);

passe_bas1 = filter(h1 ,1 , signal);
passe_bas2 = filter(h2 ,1 , signal);

plot(temps, signal);
hold on
plot(temps,passe_bas1);
hold on
plot(temps,passe_bas2);
legend("Original","N=11", "N=61");

figure
plot(f, abs(fft(signal)));
hold on
plot(f,abs(fft(passe_bas1)));
hold on
plot(f,abs(fft(passe_bas2)));
legend("Original","N=11", "N=61");

figure
plot(linspace(-fe/2,fe/2,N), fftshift(abs(fft(signal))));
hold on
plot(linspace(-fe/2,fe/2,length(fft(h1))),50*fftshift(abs(fft(h1))));
hold on
plot(linspace(-fe/2,fe/2,length(fft(h2))),50*fftshift(abs(fft(h2))));
legend("Original","h1", "h2");