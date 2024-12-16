close all
clear all

Data = load('playback_44100.mat');
pcm_441000_signal = Data.w441;

FS = 44100;                                 % Fréquence d'échantillonage
N = length(pcm_441000_signal);              % Nombre de points
fft_signal = fft(pcm_441000_signal);        % Transformée de Fourier
f = (0:N-1)*(FS/N);                         % Axe des fréquences (en Hz)
t = (0:N-1)/FS;                             % Axe temporel (en s)

% Amplitude et phase
amplitude = abs(fft_signal);        % Amplitude spectrale
phase = angle(fft_signal);          % Phase spectrale

% Représentation des échantillons
figure(1);
subplot(4,1,1);
plot(pcm_441000_signal);
title("Représentation des échantillons du signal pcm 44100 kHz");
xlabel("Échantillons");
ylabel("Amplitude");

subplot(4,1,2);
plot(pcm_441000_signal);
xlim([260000 2800000]);
title("Zoom sur les échantillons");
xlabel("Échantillons");
ylabel("Amplitude");

% Représentation temporelles des échantillons
subplot(4,1,3);
plot(t, pcm_441000_signal);
title("Représentation temporelle du signal pcm 44100 kHz");
xlabel("Temps (s)");
ylabel("Amplitude");

subplot(4,1,4);
plot(t, pcm_441000_signal);
xlim([60 65]);
title("Zoom sur le signal");
xlabel("Temps (s)");
ylabel("Amplitude");

%Représentation fréquentielle
figure(2);
subplot(2,1,1);
plot(f,amplitude);
xlim([0 30000])
title("Amplitude spectrale");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

subplot(2,1,2);
plot(f, phase); % On affiche seulement jusqu'à FS/2 (spectre positif)
title("Phase spectrale");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

%% Sur échntillonage à M = 160
% On sélectionne une portion du signal sur lequel on va travailler ( 1
% seconde)
N_seconds = 1;
N_points = FS * N_seconds;
pcm_441000_signal_cut = pcm_441000_signal(2720000:2720000+N_points-1);
t_cut = t(2720000 : N_points+2720000-1);

% Sur échantillonage
N_up = N_points*160;
t_up = (0:N_up-1)/FS;  
upsampled_signal = upsample(pcm_441000_signal_cut,160);

% Amplitude et phase
f_up = (0:N_up-1)*(FS/N_up);                         % Axe des fréquences (en Hz)
fft_signal_up = fft(upsampled_signal);
amplitude_up = abs(fft_signal_up);        % Amplitude spectrale
phase_up = angle(fft_signal_up);          % Phase spectrale

% Représentation des échantillons
figure(3);
subplot(4,1,1);
plot(upsampled_signal);
title("Représentation des échantillons du signal pcm suréchantilloné");
xlabel("Échantillons");
ylabel("Amplitude");

subplot(4,1,2);
plot(upsampled_signal);
xlim([10000 20000]);
title("Zoom sur les échantillons");
xlabel("Échantillons");
ylabel("Amplitude");

% Représentation temporelles des échantillons
subplot(4,1,3);
plot(t_up, upsampled_signal);
title("Représentation temporelle du signal pcm 44100 kHz");
xlabel("Temps (s)");
ylabel("Amplitude");

subplot(4,1,4);
plot(t_up, upsampled_signal);
xlim([0 10]);
title("Zoom sur le signal (0 à 10s)");
xlabel("Temps (s)");
ylabel("Amplitude");

%Représentation fréquentielle
figure(4);
subplot(2,1,1);
plot(f_up,amplitude_up);
%xlim([0 30000])
title("Amplitude spectrale");
xlabel("Fréquence (Hz)");
ylabel("Amplitude");

subplot(2,1,2);
plot(f_up, phase_up); % On affiche seulement jusqu'à FS/2 (spectre positif)
title("Phase spectrale");
xlabel("Fréquence (Hz)");
ylabel("Phase (radians)");

%% Filtrage passe bas 