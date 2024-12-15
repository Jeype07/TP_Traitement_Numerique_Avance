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
subplot(3,1,1);
stem(pdm_signal(1:500));
title("Représentation des 50 premiers échantillons");
xlabel("Échantillons");
ylabel("Amplitude");

% Amplitude et phase
amplitude = abs(fft_signal);        % Amplitude spectrale
phase = angle(fft_signal);          % Phase spectrale

% Représentation de l'amplitude spectrale
subplot(3,1,2);
plot(f, amplitude); % On affiche seulement jusqu'à FS/2 (spectre positif)
xlim([0 30000])
title("Amplitude spectrale");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

% Représentation de la phase spectrale
subplot(3,1,3);
plot(f, phase); % On affiche seulement jusqu'à FS/2 (spectre positif)
xlim([0 30000])
title("Phase spectrale");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

%% Faire une décimation 1. filtrer 2.sous échantillonner
%paramètres du filtre : 
% fc = 20 kHz
% BP = [20k : fs/2M] = [20k : 24k]
% Gain = 1 dB
% atténuation = (6.02*20bits + 1.76) = 122.16 dB
% on choisit un filtre passe bas IIR elliptique

%% Filtrage en cascade 

% Filtre 1 M = 16
Hd1 = filter_1_order_5();  % Fonction elliptique fournie
[b1, a1] = tf(Hd1);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_signal1 = filtfilt(b1, a1, fft_signal);
% Amplitude et phase
filtered_amplitude1 = abs(filtered_signal1);        % Amplitude spectrale
filtered_phase1 = angle(filtered_signal1);          % Phase spectrale

% Filtre 2 M = 4
Hd2 = filter_2_order_5();  % Fonction elliptique fournie
[b2, a2] = tf(Hd2);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_signal2 = filtfilt(b2, a2, filtered_signal1);
% Amplitude et phase
filtered_amplitude2 = abs(filtered_signal2);        % Amplitude spectrale
filtered_phase2 = angle(filtered_signal2);          % Phase spectrale

% Filtre 3 M = 2
Hd3 = filter_3_order_3();  % Fonction elliptique fournie
[b3, a3] = tf(Hd3);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_signal3 = filtfilt(b3, a3, filtered_signal2);
% Amplitude et phase
filtered_amplitude3 = abs(filtered_signal3);        % Amplitude spectrale
filtered_phase3 = angle(filtered_signal3);          % Phase spectrale

%% Plots

figure(2);
% Représentation de la phase filtrée du signal 
subplot(2,1,2);
plot(f, filtered_phase1); 
xlim([0 30000]);
title("Phase filtrée");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");
% Représentation de l'amplitude spectrale
subplot(2,1,1);
plot(f, filtered_amplitude1); 
xlim([0 30000]);
title("Amplitude spectrale filtrée");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

figure(3);
% Représentation de la phase filtrée du signal 
subplot(2,1,2);
plot(f, filtered_phase2); 
xlim([0 30000]);
title("Phase filtrée");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");
% Représentation de l'amplitude spectrale
subplot(2,1,1);
plot(f, filtered_amplitude2); 
xlim([0 30000]);
title("Amplitude spectrale filtrée");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

figure(4);
% Représentation de la phase filtrée du signal 
subplot(2,1,2);
plot(f, filtered_phase3); 
xlim([0 30000]);
title("Phase filtrée");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");
% Représentation de l'amplitude spectrale
subplot(2,1,1);
plot(f, filtered_amplitude3); 
xlim([0 30000]);
title("Amplitude spectrale filtrée");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");
