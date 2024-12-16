close all
clear all

numberOfSeconds = 1;

Data = load('playback_44100.mat');
pcm_signal = Data.w441;
FS  = 44.1e3;  % Frequency
numberOfSamples = FS * numberOfSeconds;
t = (0:length(pcm_signal)-1)/FS;
t_frac = linspace(0, numberOfSeconds, numberOfSamples);
N=length(t_frac)
fraction_signal = pcm_signal(2720000:N+2720000-1);

% Représentation des 50 premiers échantillons
figure(1);
subplot(2,1,1);
plot(t, pcm_signal);
title("Représentation des 50 premiers échantillons du signal pdm in");
xlabel("Durée (s)");
ylabel("Amplitude");

subplot(2,1,2);
plot(t_frac,fraction_signal);
title("Représentation des 50 premiers échantillons du signal pdm in");
xlabel("Durée (s)");
ylabel("Amplitude");

%% Interpolation
%upsample_fraction_signal = interp(fraction_signal,160);

upsample_fraction_signal1 = upsample(fraction_signal,160); %on utilise upsample (même méthode que le cours)
%upsample_signal = interp(pcm_signal,160);

t_frac_upsample = (0:length(upsample_fraction_signal1)-1)/FS;
%t_upsample = (0:length(upsample_signal)-1)/FS;

figure(2);
subplot(2,1,1);
plot(t_frac,fraction_signal);
title("Représentation d'une seconde du signal audio 44,1kHz");
xlabel("Durée (s)");
ylabel("Amplitude");

subplot(2,1,2);
plot(t_frac_upsample,upsample_fraction_signal1);
title("Représentation upsample par 160 d'une seconde du signal audio 44,1kHz");
xlabel("Durée (s)");
ylabel("Amplitude");

%% Filtrage  
N = length(upsample_fraction_signal1);             % Nombre de points

f = (0:N-1)*(FS/N);                 % Axe des fréquences (en Hz)
% Filtre 1 M = 147
Hd1 = ellipticOrdre7();  % Fonction elliptique fournie
[b1, a1] = tf(Hd1);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_pcm_signal1 = fftshift(filter(Hd1, upsample_fraction_signal1));
filtered_signal1 = fft(filtered_pcm_signal1);

% Amplitude et phase
filtered_amplitude1 = abs(filtered_signal1);        % Amplitude spectrale
filtered_phase1 = angle(filtered_signal1);          % Phase spectrale
amplitude = abs(fftshift(fft(upsample_fraction_signal1)));
phase = angle(fft(upsample_fraction_signal1));

figure(3);
% Représentation de la phase filtrée du signal 
subplot(2,1,1);
plot(f, amplitude); 

title("Amplitude spectrale filtrée");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");
% Représentation de l'amplitude spectrale
subplot(2,1,2);
plot(f, phase); 

title("Phase filtrée");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

% Représentation de la phase filtrée du signal 
subplot(2,2,1);
plot(f, filtered_amplitude1); 

title("Amplitude spectrale filtrée");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");
% Représentation de l'amplitude spectrale
subplot(2,2,2);
plot(f, filtered_phase1); 

title("Phase filtrée");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");