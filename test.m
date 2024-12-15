close all
clear all

Data = load('pdm_in.mat');
pdm_signal = Data.in;
FS  = 6.144e6;  % Frequency
x_lim = 50000;
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
stem(pdm_signal(1:200));
title("Représentation des 200 premiers échantillons de pdm");
xlabel("Échantillons");
ylabel("Amplitude");

% Amplitude et phase
amplitude = abs(fft_signal);        % Amplitude spectrale
phase = angle(fft_signal);          % Phase spectrale

% Représentation de l'amplitude spectrale
subplot(3,1,2);
plot(f, amplitude); % On affiche seulement jusqu'à FS/2 (spectre positif)
xlim([0 x_lim])
title("Amplitude spectrale");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

% Représentation de la phase spectrale
subplot(3,1,3);
plot(f, phase); % On affiche seulement jusqu'à FS/2 (spectre positif)
xlim([0 x_lim])
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
M1=16;
Hd1 = filter_1_order_5();  % Fonction elliptique fournie
[b1, a1] = tf(Hd1);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_pdm_signal1 = filtfilt(b1, a1, pdm_signal);
filtered_signal1 = fft(filtered_pdm_signal1);
% Amplitude et phase
filtered_amplitude1 = abs(filtered_signal1);        % Amplitude spectrale
filtered_phase1 = angle(filtered_signal1);          % Phase spectrale
signal_decim1 = filtered_signal1(1:M1:end);

% Filtre 2 M = 4
M2 = 4;
Hd2 = filter_2_order_8();  % Fonction elliptique fournie
[b2, a2] = tf(Hd2);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_pdm_signal2 = filtfilt(b2, a2, signal_decim1);
filtered_signal2 = fft(filtered_pdm_signal2);
% Amplitude et phase
filtered_amplitude2 = abs(filtered_signal2);        % Amplitude spectrale
filtered_phase2 = angle(filtered_signal2);          % Phase spectrale
signal_decim2 = filtered_signal2(1:M2:end);

% Filtre 3 M = 2
M3 = 2;
Hd3 = filter_3_order_12();  % Fonction elliptique fournie
[b3, a3] = tf(Hd3);                     % Obtenir les coefficients du filtre IIR
% Appliquer le filtre passe-bas
filtered_pdm_signal3 = filtfilt(b3, a3, signal_decim2);
filtered_signal3 = fft(filtered_pdm_signal3);
% Amplitude et phase
filtered_amplitude3 = abs(filtered_signal3);        % Amplitude spectrale
filtered_phase3 = angle(filtered_signal3);          % Phase spectrale
signal_decim3 = filtered_signal2(1:M3:end);

%% Plots

% Après chaque filtrage et décimation, recalculer f
f_decim1 = (0:length(filtered_pdm_signal1)-1) * (FS/length(filtered_pdm_signal1));
f_decim2 = (0:length(filtered_pdm_signal2)-1) * (FS/length(filtered_pdm_signal2));
f_decim3 = (0:length(filtered_pdm_signal3)-1) * (FS/length(filtered_pdm_signal3));

% Tracer la phase et l'amplitude pour chaque filtre
figure(2);
subplot(2,1,1);
plot(f_decim1, filtered_amplitude1);
xlim([0 x_lim]);
title("Amplitude spectrale filtrée (Filtre 1)");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

subplot(2,1,2);
plot(f_decim1, filtered_phase1);
xlim([0 x_lim]);
title("Phase filtrée (Filtre 1)");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

figure(3);
subplot(2,1,1);
plot(f_decim2, filtered_amplitude2);
xlim([0 x_lim]);
title("Amplitude spectrale filtrée (Filtre 2)");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

subplot(2,1,2);
plot(f_decim2, filtered_phase2);
xlim([0 x_lim]);
title("Phase filtrée (Filtre 2)");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

figure(4);
subplot(2,1,1);
plot(f_decim3, filtered_amplitude3);
xlim([0 x_lim]);
title("Amplitude spectrale filtrée (Filtre 3)");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

subplot(2,1,2);
plot(f_decim3, filtered_phase3);
xlim([0 x_lim]);
title("Phase filtrée (Filtre 3)");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

% Représentation des 200 premiers échantillons du signal décimé final
figure(5);
stem(signal_decim3(1:200));
title("Représentation des 200 premiers échantillons");
xlabel("Échantillons");
ylabel("Amplitude");
