close all
clear all

Data = load('pdm_in.mat');
pdm_signal = Data.in;
FS  = 6.144e6;  % Frequency
%audiowrite('Sound.wav', pdm_signal, FS);

%% Calcul de la FFT
N = length(pdm_signal);             % Nombre de points
fft_signal = fft(pdm_signal);       % Transformée de Fourier
f = (0:N-1)*(FS/N);                 % Axe des fréquences (en Hz)

% Amplitude et phase
amplitude = abs(fft_signal);        % Amplitude spectrale
phase = angle(fft_signal);          % Phase spectrale

% Représentation des 50 premiers échantillons
figure(1);
stem(pdm_signal(1:500));
title("Représentation des 50 premiers échantillons");
xlabel("Échantillons");
ylabel("Amplitude");

% Amplitude et phase
amplitude = abs(fft_signal);        % Amplitude spectrale
phase = angle(fft_signal);          % Phase spectrale

% Représentation de l'amplitude spectrale
figure(2);
plot(f, amplitude); % On affiche seulement jusqu'à FS/2 (spectre positif)
xlim([0 30000])
title("Amplitude spectrale");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

% Représentation de la phase spectrale
figure(3);
plot(f, phase); % On affiche seulement jusqu'à FS/2 (spectre positif)
xlim([0 30000])
title("Phase spectrale");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

%% Faire une décimation 1. filtrer 2.sous échantillonner
%paramètres du filtre : 
% fc = kHz
% BP = 20k : fs/2M = 20k : 24k
% Gain = 1
% atténuation = (6.02*20bits + 1.76) = 122.16 dB
% on choisit un filtre passe bas IIR elliptique

%% Configuration du filtre passe bas elliptique
Hd = filter_lp_elliptic_order_13();  % Fonction elliptique fournie
[b, a] = tf(Hd);                     % Obtenir les coefficients du filtre IIR

% Appliquer le filtre passe-bas
filtered_signal = filtfilt(b, a, pdm_signal);
% Amplitude et phase
filtered_amplitude = abs(filtered_signal);        % Amplitude spectrale
filtered_phase = angle(filtered_signal);          % Phase spectrale

% Représentation de la phase filtrée du signal 
figure(4);
plot(f, filtered_phase); 
xlim([0 30000])
title("Phase filtrée");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

% Représentation de l'amplitude spectrale
figure(5);
plot(f, filtered_amplitude); 
xlim([0 30000])
title("Amplitude spectrale filtrée");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");